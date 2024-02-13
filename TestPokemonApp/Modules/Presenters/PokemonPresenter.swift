import Foundation

class PokemonPresenter: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    
    private let interactor = PokemonInteractor()
    
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
