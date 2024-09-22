//
//  TableViewCell.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import UIKit
import SwiftUI

class CharacterCell: UITableViewCell {
    private let containerView = UIView()
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let imagePadding: CGFloat = 10
        static let imageSize: CGFloat = 60
        static let cellPadding: CGFloat = 5
        static let labelPadding: CGFloat = 10
        static let borderWidth: CGFloat = 0.4
        static let nameFontSize: CGFloat = 15
        static let speciesFontSize: CGFloat = 13
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        [containerView, characterImageView, nameLabel, speciesLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(containerView)
        [characterImageView, nameLabel, speciesLabel].forEach { containerView.addSubview($0) }
        
        setupContainerView()
        setupCharacterImageView()
        setupConstraints()
    }
    
    private func setupContainerView() {
        containerView.layer.borderWidth = Constants.borderWidth
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.clipsToBounds = true
    }
    
    private func setupCharacterImageView() {
        characterImageView.layer.cornerRadius = Constants.cornerRadius
        characterImageView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.cellPadding),
            
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.imagePadding),
            characterImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            characterImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            characterImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: Constants.labelPadding),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.labelPadding),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.labelPadding),
            
            speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            speciesLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            speciesLabel.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
            speciesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.labelPadding)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        speciesLabel.textColor = .gray
        nameLabel.font = .systemFont(ofSize: Constants.nameFontSize, weight: .semibold)
        speciesLabel.font = .systemFont(ofSize: Constants.speciesFontSize, weight: .regular)
        
        setBackgroundColor(for: character.status)
        loadImage(from: character.image)
    }
    
    private func setBackgroundColor(for status: String) {
        containerView.backgroundColor = {
            switch status.lowercased() {
            case "alive": return .lightGreen
            case "dead": return .lightRed
            default: return .white
            }
        }()
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        characterImageView.image = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.characterImageView.image = image
            }
        }.resume()
    }
}
