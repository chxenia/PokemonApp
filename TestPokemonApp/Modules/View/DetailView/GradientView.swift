//
//  GradientView.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import SwiftUI

struct GradientView: View {
    let colors: [Color]
    let size: CGSize
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .shadow(radius: 10)
            .blur(radius: 85)
            .offset(x: 0, y: -50)
    }
}


