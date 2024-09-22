//
//  CharacterListViewModelTests.swift
//  RickAndMortyCharactersTests
//
//  Created by Munachimso Ugorji on 9/22/24.
//

import XCTest
import Combine
@testable import RickAndMortyCharacters

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel!
    var mockAPI: MockRickAndMortyAPI!

    override func setUp() {
        super.setUp()
        mockAPI = MockRickAndMortyAPI()
        viewModel = CharacterListViewModel(api: mockAPI)
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }

    func testLoadCharacters() {
        let expectation = XCTestExpectation(description: "Load characters")
        mockAPI.mockCharacters = [Character(
            id: 1,
            name: "Rick",
            species: "Human",
            status: "Alive",
            gender: "Male",
            image: "https://example.com/rick.jpg",
            location: Location(name: "Earth", url: ""))]
        
        viewModel.loadCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.characters.count, 1)
            XCTAssertEqual(self.viewModel.characters[0].name, "Rick")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFilterCharacters() {
        viewModel.characters = [
            Character(
                id: 1,
                name: "Rick",
                species: "Human", 
                status: "Alive",
                gender: "Male",
                image: "https://example.com/rick.jpg", 
                location: Location(name: "Earth", url: "")),
            Character(
                id: 2,
                name: "Morty",
                species: "Human", 
                status: "Dead",
                gender: "Male",
                image: "https://example.com/morty.jpg", 
                location: Location(name: "Earth", url: ""))
        ]
        
        viewModel.selectedFilter = .alive
        XCTAssertEqual(viewModel.filteredCharacters.count, 1)
        XCTAssertEqual(viewModel.filteredCharacters[0].name, "Rick")
        
        viewModel.selectedFilter = .dead
        XCTAssertEqual(viewModel.filteredCharacters.count, 1)
        XCTAssertEqual(viewModel.filteredCharacters[0].name, "Morty")
        
        viewModel.selectedFilter = nil
        XCTAssertEqual(viewModel.filteredCharacters.count, 2)
    }
}

class MockRickAndMortyAPI: RickAndMortyAPI {
    var mockCharacters: [Character] = []
    
    override func fetchCharacters(page: Int) -> AnyPublisher<[Character], Error> {
        return Just(mockCharacters)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
