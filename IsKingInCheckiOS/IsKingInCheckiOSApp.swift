import SwiftUI

@main
struct IsKingInCheckiOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            if let mock = appDelegate.configuration["MockName"] {
                switch mock {
                case "MockInCheck": ContentView(apiClient: .mock(chessboardStatus: .mockInCheck))
                case "MockNotInCheck": ContentView(apiClient: .mock(chessboardStatus: .mockNotInCheck))
                default: fatalError()
                }
            } else {
                ContentView(apiClient: .live)
            }
        }
    }
}
