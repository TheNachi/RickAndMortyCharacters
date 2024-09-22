//
//  CharacterDetailsView.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import SwiftUI

struct CharacterDetailsView: View {
    @StateObject private var viewModel: CharacterDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(character: Character) {
        _viewModel = StateObject(wrappedValue: CharacterDetailsViewModel(character: character))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                characterImage
                characterInfoSection
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: customBackButton)
    }
        
    private var characterImage: some View {
        AsyncImage(url: URL(string: viewModel.character.image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: UIScreen.main.bounds.height / 3 + 100)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        } placeholder: {
            Color.gray
                .frame(height: UIScreen.main.bounds.height / 3 + 100)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
    
    private var characterInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            nameAndStatus
            speciesAndGender
            locationInfo
        }
        .padding(.horizontal, 20)
    }
    
    private var nameAndStatus: some View {
        HStack {
            Text(viewModel.character.name)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(viewModel.character.status)
                .font(.subheadline)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(viewModel.statusColor(for: viewModel.character.status))
                .foregroundColor(.black)
                .cornerRadius(15)
        }
    }
    
    private var speciesAndGender: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(viewModel.character.species)
                .foregroundColor(.black)
            Text("•")
                .foregroundColor(.secondary)
            Text(viewModel.character.gender)
                .foregroundColor(.secondary)
        }
        .font(.subheadline)
    }
    
    private var locationInfo: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text("Location:")
                .foregroundColor(.black)
            Text(viewModel.character.location.name)
                .foregroundColor(.secondary)
        }
        .font(.subheadline)
    }
    
    private var customBackButton: some View {
        Button(action: {
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .padding(10)
                .background(Circle().fill(Color.white))
                .shadow(radius: 3)
        }
        .frame(width: 40, height: 40)
    }
}
