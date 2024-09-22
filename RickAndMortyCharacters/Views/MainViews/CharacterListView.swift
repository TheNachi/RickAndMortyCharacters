//
//  CharacterListView.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    @State private var selectedCharacter: Character?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Characters")
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                
                HStack {
                    FilterBarView(selectedFilter: $viewModel.selectedFilter)
                }
                
                if !viewModel.characters.isEmpty {
                    CharacterTableView(
                        characters: .constant(viewModel.filteredCharacters),
                        loadNextPage: viewModel.loadNextPage,
                        isLoading: viewModel.isLoading,
                        isLastPage: viewModel.isLastPage,
                        onCharacterSelect: { character in
                            selectedCharacter = character
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .onAppear {
                viewModel.loadCharacters()
            }
            .navigationDestination(item: $selectedCharacter) { character in
                    CharacterDetailsView(character: character)
            }
        }
    }
}

