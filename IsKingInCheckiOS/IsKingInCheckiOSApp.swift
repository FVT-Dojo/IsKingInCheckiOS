import SwiftUI

@main
struct IsKingInCheckiOSApp: App {
    
    var body: some Scene {
        WindowGroup {
            ChessboardView(viewModel: ChessboardViewModel(apiClient: .live))
        }
    }
}
