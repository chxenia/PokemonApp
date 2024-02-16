//
//  ErrorView.swift
//  TestPokemonApp
//
//  Created by Xenia on 14.02.2024.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    
    var body: some View {
        VStack {
            Text("Error Occurred")
                .font(.title)
                .foregroundColor(.red)
            Text(error.localizedDescription)
                .foregroundColor(.red)
        }
        .padding()
    }
}
