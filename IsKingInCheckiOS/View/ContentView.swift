//
//  ContentView.swift
//  IsKingInCheckiOS
//
//  Created by Arthur van Aarssen on 01/05/2024.
//

import SwiftUI

struct ContentView: View {
    var apiClient: ApiClient
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Start the game") {
                    ChessboardView(viewModel: ChessboardViewModel(apiClient: apiClient))
                }.accessibilityIdentifier("startGameButton")
            }
            .padding()
        }
        
    }
}
