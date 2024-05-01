import SwiftUI

// Model
struct ChessboardSquare {
    enum Piece {
        case king
        case rook
    }
    let color: Color
    var piece: Piece? = nil
}

struct ChessboardStatus: Codable {
    let chessboard: [[String]]
    let isKingInCheck: Bool
}

extension ChessboardStatus {
    static let mockNotInCheck = ChessboardStatus(
        chessboard: [
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["R", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "K", "", "", ""]
        ],
        isKingInCheck: false
    )
    
    static let mockInCheck = ChessboardStatus(
        chessboard: [
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", ""],
            ["R", "", "", "", "K", "", "", ""]
        ],
        isKingInCheck: true
    )
}

struct ApiClient {
    var fetchChessboard: () async throws -> ChessboardStatus
}

extension ApiClient {
    static let mock = ApiClient {
        .mockNotInCheck
    }
}

// ViewModel for the Chessboard
class ChessboardViewModel: ObservableObject {
    // Represents the colors of the squares on the chessboard
    @Published var squares: [[ChessboardSquare]] = []
    var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        fetchChessboard()
    }
    
    func generateChessboard(chessboardStatus: ChessboardStatus) {
        squares = (0..<8).map { row in
            (0..<8).map { column in
                let value = chessboardStatus.chessboard[row][column]
                let piece = value == "R" ? ChessboardSquare.Piece.rook : value == "K" ? ChessboardSquare.Piece.king : nil
                return (row + column) % 2 == 0 ? ChessboardSquare(color: .white, piece: piece) : ChessboardSquare(color: .black, piece: piece)
            }
        }
    }
    
    func fetchChessboard() {
        Task {
            do {
                let result = try await apiClient.fetchChessboard()
                return
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}

// View for a single square on the chessboard
struct SquareView: View {
    let square: ChessboardSquare
    
    var body: some View {
        Rectangle()
            .fill(square.color)
    }
}

// View for the Chessboard
struct ChessboardView: View {
    @ObservedObject var viewModel = ChessboardViewModel(apiClient: .mock)
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<8, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { column in
                        SquareView(square: viewModel.squares[row][column])
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
}

#Preview {
    ChessboardView()
}
