//
//  CharacterDetailsViewModelTests.swift
//  RickAndMortyCharactersTests
//
//  Created by Munachimso Ugorji on 9/22/24.
//

import XCTest
@testable import RickAndMortyCharacters

class CharacterDetailsViewModelTests: XCTestCase {
    var viewModel: CharacterDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        let character = Character(
            id: 1,
            name: "Rick",
            species: "Human", status: "Alive",
            gender: "Male",
            image: "https://example.com/rick.jpg", location: Location(name: "Earth", url: ""))
        viewModel = CharacterDetailsViewModel(character: character)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testStatusColor() {
        XCTAssertEqual(viewModel.statusColor(for: "Alive"), .green)
        XCTAssertEqual(viewModel.statusColor(for: "Dead"), .red)
        XCTAssertEqual(viewModel.statusColor(for: "Unknown"), .gray)
    }
}
