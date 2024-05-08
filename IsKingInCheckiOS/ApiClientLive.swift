
import Foundation

extension ApiClient {
    static let live = ApiClient(fetchChessboard: fetchChessboardIMPL)
}

func fetchChessboardIMPL() async throws -> ChessboardStatus {
    let url = URL(string: "http://localhost:5000/game")! // Ok for this case, since we know that it is an url. Do not do this when it is not hand written..
    let urlRequest = URLRequest(url: url)
    return try await withCheckedThrowingContinuation { continuation in
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let jsonDecoder = JSONDecoder()
            do {
                if let data {
                    let result = try jsonDecoder.decode(ChessboardStatus.self, from: data)
                    continuation.resume(returning: result)
                } else if let error {
                    print("something went wrong here!!!!")
                    continuation.resume(throwing: error)
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
