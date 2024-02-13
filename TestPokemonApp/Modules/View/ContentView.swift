//
//  ContentView.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

struct PokemonView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
