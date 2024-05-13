import Foundation

struct ApiClient {
    var fetchChessboard: () async throws -> ChessboardStatus
}

extension ApiClient {
//    static let mock = ApiClient {
//        .mockNotInCheck
//    }
    
    static func mock(chessboardStatus: ChessboardStatus) -> Self {
        ApiClient {
            chessboardStatus
        }
    }
}
