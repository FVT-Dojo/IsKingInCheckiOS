import SwiftUI

@MainActor
class ChessboardViewModel: ObservableObject {
    @Published var squares: [[ChessboardSquare]] = []
    @Published var isKingInCheck = false
    @Published var chessboardReady = false
    
    var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func task() async {
        do {
            let response = try await apiClient.fetchChessboard()
            
            generateChessboard(chessboardStatus: response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func generateChessboard(chessboardStatus: ChessboardStatus?) {
        guard let chessboardStatus = chessboardStatus else { return }
        
        squares = (0..<8).map { row in
            (0..<8).map { column in
                let piece = chessboardStatus.chessboard[row][column]
                let color = (row + column) % 2 == 0 ? Color.white : Color.black
                return ChessboardSquare(color: color, piece: piece)
            }
        }
        
        isKingInCheck = chessboardStatus.isKingInCheck
        
        chessboardReady = true
    }
}
