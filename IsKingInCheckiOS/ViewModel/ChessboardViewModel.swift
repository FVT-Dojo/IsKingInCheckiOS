import SwiftUI

class ChessboardViewModel: ObservableObject {
    @Published var squares: [[ChessboardSquare]] = []
    @Published var chessboardReady = false
    
    var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        fetchChessboard(completion: self.generateChessboard)
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
        
        chessboardReady = true
    }
    
    func fetchChessboard(completion: @escaping (ChessboardStatus?) -> Void) {
        Task {
            do {
                let response = try await apiClient.fetchChessboard()
                completion(response)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
