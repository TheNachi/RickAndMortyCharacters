//
//  CharacterListViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/22/24.
//

import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var isLastPage = false
    @Published var selectedFilter: FilterBarView.FilterOption?
    
    private let api: RickAndMortyAPI
    
    init(api: RickAndMortyAPI = RickAndMortyAPI.shared) {
        self.api = api
    }
    
    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    
    var filteredCharacters: [Character] {
        guard let filter = selectedFilter else { return characters }
        return characters.filter { $0.status.lowercased() == filter.rawValue.lowercased() }
    }
    
    func loadCharacters() {
        guard !isLoading && !isLastPage else { return }
        isLoading = true
        
        api.fetchCharacters(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching characters: \(error)")
                }
            } receiveValue: { newCharacters in
                if newCharacters.isEmpty {
                    self.isLastPage = true
                } else {
                    self.characters.append(contentsOf: newCharacters)
                    self.currentPage += 1
                }
            }
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        loadCharacters()
    }
}
