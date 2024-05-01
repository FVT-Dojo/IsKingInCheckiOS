//
//  ContentView.swift
//  IsKingInCheckiOS
//
//  Created by Arthur van Aarssen on 01/05/2024.
//

import SwiftUI

class ViewModel: ObservableObject {
    var isGameStarted = false
    
    func startButtonTapped() {
        isGameStarted = true
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isGameStarted {
            } else {
                Button {
                    viewModel.startButtonTapped()
                } label: {
                    Text(verbatim: "Start the game")
                        .padding()
                        .background(Color.blue.cornerRadius(15.0))
                        .foregroundColor(.white)
                }
                .accessibilityIdentifier("startGameButton")
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
