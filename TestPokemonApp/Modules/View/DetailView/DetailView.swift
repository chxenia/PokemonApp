//
//  DetailView.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
    }
}

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        Text(errorMessage)
    }
}

struct DetailView: View {
    let url: String
    @State private var pokemonInfo: PokemonInfo?
    
    private var pokemonNumber: String {
        guard let number = Int(url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "").replacingOccurrences(of: "/", with: "")) else {
            return "N/A"
        }
        return "#\(number)"
    }
    
    var body: some View {
        ZStack {
            GradientView(colors: [TypeColors.colors[pokemonInfo?.types.first?.type.name ?? "grass"] ?? .green, TypeColors.colors[pokemonInfo?.types.first?.type.name ?? "grass"] ?? .blue], size: CGSize(width: 200, height: 200))
            
            VStack {
                HeaderView(pokemonNumber: pokemonNumber)
                
                Spacer()
                
                if let pokemonInfo = pokemonInfo {
                    ImageView(imageURL: pokemonInfo.sprites.front_default ?? "")
                    
                    Text("\(pokemonInfo.name.capitalized)")
                        .font(.largeTitle.bold())
                    
                    StatsView(height: pokemonInfo.height, weight: pokemonInfo.weight)
                    
                    TypesView(types: pokemonInfo.types.map { $0.type.name })
                    
                    Spacer()
                } else {
                    LoadingView()
                }
            }
            .onAppear {
                loadData()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func loadData() {
        PokemonInteractor(pokemonService: PokemonService(networkService: NetworkService())).fetchPokemonDetail(url: url) { result in
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
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/6/")
    }
}
