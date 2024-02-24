//
//  HeaderView.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import SwiftUI

struct HeaderView: View {
    let pokemonNumber: String
    
    var body: some View {
        VStack {
            Text(pokemonNumber)
                .font(.largeTitle.bold())
            
        }
    }
}
