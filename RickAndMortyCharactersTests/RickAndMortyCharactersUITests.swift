//
//  RickAndMortyCharactersUITests.swift
//  RickAndMortyCharactersTests
//
//  Created by Munachimso Ugorji on 9/22/24.
//

import XCTest

class RickAndMortyCharactersUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testCharacterListView() {
        let charactersTable = app.tables.firstMatch
        XCTAssertTrue(charactersTable.exists)
        
        let cell = charactersTable.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        
        let aliveButton = app.buttons["Alive"]
        XCTAssertTrue(aliveButton.exists)
        aliveButton.tap()
        
        cell.tap()
        let characterName = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(characterName.waitForExistence(timeout: 2))
    }
    
    func testCharacterDetailsView() {
        let charactersTable = app.tables.firstMatch
        let cell = charactersTable.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()
        
        let characterImage = app.images.firstMatch
        XCTAssertTrue(characterImage.exists)
        
        XCTAssertTrue(charactersTable.exists)
    }
}
