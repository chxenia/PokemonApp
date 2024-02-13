import Foundation

class PokemonPresenter: ObservableObject {
    public var view: PokemonView?
    public let interactor: PokemonInteractor
    
    @Published var pokemons: [Pokemon] = []
    
    init(interactor: PokemonInteractor, view: PokemonView?) {
        self.view = view
        self.interactor = interactor
    }
    
    func fetchPokemonList(page: Int) {
        interactor.fetchPokemonList(page: page) { [weak self] result in
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
