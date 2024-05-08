
import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
}

extension ApiClient {
    static let live = ApiClient(fetchChessboard: fetchChessboardIMPL)
}

func fetchChessboardIMPL() async throws -> ChessboardStatus {
    guard let url = URL(string: "http://localhost:5000/game") else {
        throw NetworkError.invalidURL
    }
    
    let urlRequest = URLRequest(url: url)
    
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw NetworkError.invalidResponse
    }
    
    do {
        let jsonDecoder = JSONDecoder()
        let result = try jsonDecoder.decode(ChessboardStatus.self, from: data)
        return result
    } catch {
        throw NetworkError.decodingError
    }
}
