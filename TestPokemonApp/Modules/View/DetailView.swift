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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [TypeColors.colors[pokemonInfo?.types.first?.type.name ?? "grass"] ?? .green, TypeColors.colors[pokemonInfo?.types.first?.type.name ?? "grass"] ?? .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(radius: 10)
                .blur(radius: 85)
                .offset(x: 0, y: -50)
            
            VStack {
                Spacer()
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
                    
                    HStack(spacing: 20){
                        VStack {
                            Text("\(String(format: "%.0f", pokemonInfo.height * 10)) cm")
                            Text("Height")
                                .foregroundColor(.gray)
                            
                        }
                        
                        VStack {
                            Text("\(String(format: "%.0f", pokemonInfo.weight / 10)) kg")
                            Text("Weight")
                                .foregroundColor(.gray)
                        }
                    }
                    .offset(y: -20)
                    .font(.caption)
                    
                    Text("\(pokemonInfo.name.capitalized)")
                        .font(.largeTitle.bold())
                    
                    HStack(spacing: 20){
                        ForEach(pokemonInfo.types.indices, id: \.self) { index in
                           
                            Text("\(pokemonInfo.types[index].type.name)")
                                .foregroundColor(TypeColors.colors[pokemonInfo.types[index].type.name] ?? .green)
                                .padding(7)
                                .background(
                                    Capsule()
                                        .fill(Color.clear)
                                        .frame(width: 70)
                                        .overlay(
                                            Capsule()
                                                .stroke(TypeColors.colors[pokemonInfo.types[index].type.name] ?? .green, lineWidth: 2)
                                        )
                                )
                        }
                    }
                    

                   
                    
                    Spacer()
                    
                } else {
                    ProgressView("Loading...")
                }
            }
            .onAppear {
                loadData()
            }
            
        }
        .preferredColorScheme(.dark)

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
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/3/")
    }
}
