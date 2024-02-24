//
//  TypesView.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import SwiftUI

struct TypesView: View {
    let types: [String]
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(types, id: \.self) { type in
                Text(type)
                    .foregroundColor(TypeColors.colors[type] ?? .green)
                    .padding(7)
                    .background(
                        Capsule()
                            .fill(Color.clear)
                            .frame(width: 70)
                            .overlay(
                                Capsule()
                                    .stroke(TypeColors.colors[type] ?? .green, lineWidth: 2)
                            )
                    )
            }
        }
    }
}
