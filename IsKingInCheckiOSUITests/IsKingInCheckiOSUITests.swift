//
//  IsKingInCheckiOSUITests.swift
//  IsKingInCheckiOSUITests
//
//  Created by Arthur van Aarssen on 01/05/2024.
//

import XCTest

final class IsKingInCheckiOSUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStartGameButtonExistsAndVerifyText() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Find the button using the accessibility identifier
        let startButton = app.buttons["startGameButton"]
        
        // Assert that the button exists
        XCTAssert(startButton.exists, "The start game button should exist.")
        
        // Verify the label text of the button
        XCTAssertEqual(startButton.label, "Start the game", "The button's label should read 'Start the game'.")
    }

    func testStartGameButtonNavigatesToChessboard() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--MockName", "MockInCheck"]
        app.launch()
        
        let startButton = app.buttons["startGameButton"]
        
        startButton.tap()
        
        let chessboard = app.staticTexts["Chessboard"]
        let chessboardExists = chessboard.waitForExistence(timeout: 5)
        
        let isKingInCheckLabel = app.staticTexts["IsKingInCheckLabel"]
        let isKingInCheckLabelExists = isKingInCheckLabel.waitForExistence(timeout: 5)
        
        XCTAssertTrue(chessboardExists, "Chessboard VStack should be present after tapping start game button.")
        XCTAssertTrue(isKingInCheckLabelExists, "The label should be there!!! :(")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
