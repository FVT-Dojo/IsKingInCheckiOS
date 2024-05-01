//
//  Chessboard.swift
//  IsKingInCheckiOS
//
//  Created by Arthur van Aarssen on 01/05/2024.
//

import Foundation
import SwiftUI

struct Chessboard: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate the size of one square
        let size = min(rect.width, rect.height) / 8
        
        // Iterate over each row and column
        for row in 0..<8 {
            for column in 0..<8 {
                // Calculate the start point of each square
                let startX = rect.origin.x + CGFloat(column) * size
                let startY = rect.origin.y + CGFloat(row) * size
                let squareRect = CGRect(x: startX, y: startY, width: size, height: size)
                
                // Add the square to the path
                path.addRect(squareRect)
            }
        }
        
        return path
    }
}

#Preview(body: {
    Chessboard()
        .fill(style: FillStyle(eoFill: true, antialiased: true))
                    .overlay(Chessboard().stroke(Color.black, lineWidth: 0.5))
                    .background(Color.clear)
})
