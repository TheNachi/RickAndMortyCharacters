//
//  CharacterTableView.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import SwiftUI

struct CharacterTableView: UIViewControllerRepresentable {
    @Binding var characters: [Character]
    var loadNextPage: () -> Void
    var isLoading: Bool
    var isLastPage: Bool
    var onCharacterSelect: (Character) -> Void

    func makeUIViewController(context: Context) -> UITableViewController {
        let tableViewController = UITableViewController(style: .plain)
        setupTableView(tableViewController.tableView, context: context)
        return tableViewController
    }

    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        context.coordinator.parent = self
        uiViewController.tableView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func setupTableView(_ tableView: UITableView, context: Context) {
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var parent: CharacterTableView
        
        init(_ parent: CharacterTableView) {
            self.parent = parent
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            parent.characters.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
            cell.configure(with: parent.characters[indexPath.row])
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            90
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            parent.onCharacterSelect(parent.characters[indexPath.row])
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
            if offsetY + height > contentHeight - 100 && !parent.isLoading && !parent.isLastPage {
                parent.loadNextPage()
            }
        }
    }
}
