import Foundation

class PokemonInteractor {
    private let pokemonService: PokemonService
    
    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemonList(page: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        pokemonService.fetchPokemonList(page: page, completion: completion)
    }
    
    func fetchPokemonDetail(url: String, completion: @escaping (Result<PokemonInfo, Error>) -> Void) {
        pokemonService.fetchPokemonDetail(url: url, completion: completion)
    }
}
