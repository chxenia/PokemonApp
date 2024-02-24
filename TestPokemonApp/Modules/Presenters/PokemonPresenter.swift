import Foundation

class PokemonPresenter: ObservableObject {
    public var view: PokemonView?
    public let interactor: PokemonInteractor
    private let pokemonService: PokemonService
    
    @Published var pokemons: [Pokemon] = []
    
    init(interactor: PokemonInteractor, pokemonService: PokemonService) {
        self.interactor = interactor
        self.pokemonService = pokemonService
    }
    
    func fetchPokemonList(page: Int) {
        pokemonService.fetchPokemonList(page: page) { [weak self] result in
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self?.pokemons = pokemons
                }
            case .failure(let error):
                print("Error fetching pokemon list: \(error.localizedDescription)")
            }
        }
    }
}
