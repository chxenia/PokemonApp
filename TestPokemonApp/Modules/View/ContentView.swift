import SwiftUI
struct ContentView: View {
    @ObservedObject var router = PokemonRouter()
    @State private var isLoading = false
    @State private var error: Error?
    @State private var pokemon: Pokemon?
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    switch router.currentRoute {
                    case .home:
                        PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(pokemonService: PokemonService(networkService: NetworkService())), view: nil), router: router)
                            .navigationTitle("Pokemon App")
                    case .detail(let pokemon):
                        DetailView(url: pokemon.url)
                            .navigationTitle(pokemon.name.capitalized)
                            .navigationBarItems(trailing: Button(action: {
                                router.navigate(to: .home)
                            }, label: {
                                Text("Back to Home")
                            }))
                    }
                }
            }
            .onAppear {
                loadData()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func loadData() {
        isLoading = true
        PokemonInteractor(pokemonService: PokemonService(networkService: NetworkService())).fetchPokemonList(page: 1) { result in
            isLoading = false
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon[0]
            case .failure(let error):
                self.error = error
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
