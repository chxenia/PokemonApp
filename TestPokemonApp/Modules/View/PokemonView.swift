//
//  ContentView.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var presenter: PokemonPresenter
    @ObservedObject var router: PokemonRouter
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
     
                PaginationView(currentPage: $currentPage, totalPageCount: totalPageCount) { page in
                                    fetchPokemonList(page: page)
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
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(), view: nil), router: PokemonRouter())
    }
}
