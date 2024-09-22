//
//  RickAndMortyAPITests.swift
//  RickAndMortyCharactersTests
//
//  Created by Munachimso Ugorji on 9/22/24.
//

import XCTest
import Combine
@testable import RickAndMortyCharacters

class RickAndMortyAPITests: XCTestCase {
    var api: RickAndMortyAPI!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        api = RickAndMortyAPI.shared
        cancellables = []
    }
    
    override func tearDown() {
        api = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchCharacters() {
        let expectation = XCTestExpectation(description: "Fetch characters")
        
        api.fetchCharacters(page: 1)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error fetching characters: \(error)")
                }
            } receiveValue: { characters in
                XCTAssertFalse(characters.isEmpty)
                XCTAssertEqual(characters.count, 20)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
