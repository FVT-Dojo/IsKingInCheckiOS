import SwiftUI

// View for a single square on the chessboard
struct SquareView: View {
    let square: ChessboardSquare
    
    var body: some View {
        Rectangle()
            .fill(square.color)
            .overlay(
                Text(square.piece)  // Directly display the piece
                    .foregroundColor(pieceColor())
                    .bold(),
                alignment: .center
            )
    }
    
    private func pieceColor() -> Color {
        // Black pieces on white and vice versa
        return square.color == .white ? .black : .white
    }
}

// Main view for the Chessboard
struct ChessboardView: View {
    @ObservedObject var viewModel: ChessboardViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.chessboardReady {
                ForEach(0..<8, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { column in
                            SquareView(square: viewModel.squares[row][column])
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }.accessibilityIdentifier("Chessboard")
                Text(viewModel.isKingInCheck ? "The king is in check" : "The king is not in check")
                    .padding()
                    .accessibilityIdentifier("IsKingInCheckLabel")
            } else {
                Text("Loading Chessboard...")
            }
        }.task {
            await viewModel.task()
        }
    }
}

#Preview("Mocked API - Not in check", body: {
    ChessboardView(viewModel: ChessboardViewModel(apiClient: .mock(chessboardStatus: .mockNotInCheck)))
})

#Preview("Mocked API - In check", body: {
    ChessboardView(viewModel: ChessboardViewModel(apiClient: .mock(chessboardStatus: .mockInCheck)))
})

#Preview("Live API", body: {
    ChessboardView(viewModel: ChessboardViewModel(apiClient: .live))
})
