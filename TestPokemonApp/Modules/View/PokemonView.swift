//
//  ContentView.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var presenter: PokemonPresenter
    @State private var currentPage = 1
    @State private var totalPageCount = 66
    
    var body: some View {
        NavigationView {
            VStack {
                List(presenter.pokemons, id: \.name) { pokemon in
                    NavigationLink(destination: DetailView(url: pokemon.url)) {
                        Text(pokemon.name)
                    }
                }
                
                HStack(spacing: 2) {
                    Button(action: {
                        if currentPage > 1 {
                            currentPage = 1
                            fetchPokemonList(page: 1)
                        }
                    }) {
                        Text("<<")
                            .padding()
                    }
                    .disabled(currentPage == 1)
                    
                    ForEach(paginationRange(), id: \.self) { page in
                        Button("\(page)") {
                            currentPage = page
                            fetchPokemonList(page: page)
                        }
                        .padding()
                        .background(currentPage == page ? Color.blue : Color.clear)
                        .foregroundColor(currentPage == page ? Color.white : Color.blue)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {
                        if currentPage < totalPageCount {
                            currentPage = totalPageCount
                            fetchPokemonList(page: totalPageCount)
                        }
                    }) {
                        Text(">>")
                    }
                    .disabled(currentPage == totalPageCount)
                }
            }
            .onAppear {
                fetchPokemonList(page: currentPage)
            }
            .navigationTitle("Pokemon App")
        }
    }
    
    private func fetchPokemonList(page: Int) {
        presenter.fetchPokemonList(page: page)
    }
    
    private func paginationRange() -> ClosedRange<Int> {
        let displayPageCount = 4
        let halfRange = displayPageCount / 2
        
        let lowerBound = max(1, currentPage - halfRange)
        let upperBound = min(totalPageCount, currentPage + halfRange)
        
        if currentPage - lowerBound < halfRange {
            return lowerBound...min(lowerBound + displayPageCount - 1, totalPageCount)
        } else if upperBound - currentPage < halfRange {
            return max(1, totalPageCount - displayPageCount + 1)...totalPageCount
        } else {
            return currentPage - halfRange...currentPage + halfRange
        }
    }
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(), view: nil))
    }
}
