import SwiftUI

// Represents a single square on the chessboard
struct ChessboardSquare {
    let color: Color
    var piece: String  // Directly use String for piece representation
}

// Represents the entire chessboard status including the positions and check state
struct ChessboardStatus: Codable {
    let chessboard: [[String]]
    let isKingInCheck: Bool
}
