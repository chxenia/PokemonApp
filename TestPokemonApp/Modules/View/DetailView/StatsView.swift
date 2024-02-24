//
//  StatsView.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import SwiftUI

struct StatsView: View {
    let height: Double
    let weight: Double
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("\(String(format: "%.0f", height * 10)) cm")
                Text("Height")
                    .foregroundColor(.gray)
            }
            VStack {
                Text("\(String(format: "%.0f", weight / 10)) kg")
                Text("Weight")
                    .foregroundColor(.gray)
            }
        }
        .font(.caption)
        .padding(.bottom)
    }
}


