//
//  ImageView.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import SwiftUI

struct ImageView: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else if phase.error != nil {
                Text("Failed to load image")
            } else {
                ProgressView()
            }
        }
    }
}
