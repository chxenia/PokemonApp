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
        VStack {
            List(presenter.pokemons, id: \.name) { pokemon in
                NavigationLink(destination: DetailView(url: pokemon.url)) {
                    Text(pokemon.name.capitalized)
                }
            }
            
            PaginationView(currentPage: $currentPage, totalPageCount: totalPageCount, action: fetchPokemonList, displayPageCount: 4, presenter: PaginationPresenter(interactor: PaginationInteractor()))
        }
        .onAppear {
            fetchPokemonList(page: currentPage)
        }
        
    }
    
    private func fetchPokemonList(page: Int) {
        presenter.fetchPokemonList(page: page)
    }
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(pokemonService: PokemonService(networkService: NetworkService())), view: nil), router: PokemonRouter())
    }
}
