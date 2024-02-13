//
//  DetailView.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

struct DetailView: View {
    let url: String
    @State private var pokemonInfo: PokemonInfo?
    
    var body: some View {
        VStack {
            if let pokemonInfo = pokemonInfo {
                AsyncImage(url: URL(string: pokemonInfo.sprites.front_default ?? "")) { phase in
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
                
                Text("Pokemon: \(pokemonInfo.name)")
                Text("Height: \(String(format: "%.2f", pokemonInfo.height / 10))")
                Text("Pokemon: \(pokemonInfo.weight)")
                Text("Type: \(pokemonInfo.types.map { $0.type.name }.joined(separator: ", "))")
                
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        PokemonInteractor().fetchPokemonDetail(url: url) { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.pokemonInfo = info
                }
            case .failure(let error):
                print("Error fetching pokemon detail: \(error.localizedDescription)")
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "")
    }
}
