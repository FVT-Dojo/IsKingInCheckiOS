//
//  IsKingInCheckiOSTests.swift
//  IsKingInCheckiOSTests
//
//  Created by Arthur van Aarssen on 01/05/2024.
//

import XCTest
@testable import IsKingInCheckiOS

@MainActor
final class ChessboardViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTaskNotInCheck() async throws {
        let chessboardViewModel = ChessboardViewModel(apiClient: .mock(chessboardStatus: .mockNotInCheck))
        
        await chessboardViewModel.task()
        
        XCTAssertTrue(chessboardViewModel.chessboardReady)
        XCTAssertFalse(chessboardViewModel.isKingInCheck)
        
        XCTAssertEqual(chessboardViewModel.squares[3][0].piece, "R")
        XCTAssertEqual(chessboardViewModel.squares[7][4].piece, "K")
    }
    
    func testTaskInCheck() async throws {
        let chessboardViewModel = ChessboardViewModel(apiClient: .mock(chessboardStatus: .mockInCheck))
        
        await chessboardViewModel.task()
        
        XCTAssertTrue(chessboardViewModel.chessboardReady)
        XCTAssertTrue(chessboardViewModel.isKingInCheck)
        
        XCTAssertEqual(chessboardViewModel.squares[7][0].piece, "R")
        XCTAssertEqual(chessboardViewModel.squares[7][4].piece, "K")
    }

}
