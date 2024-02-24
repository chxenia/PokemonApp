import SwiftUI
import CoreData

struct ContentView: View {
//    @ObservedObject var router = PokemonRouter()
    @ObservedObject var networkManager = NetworkMonitor()
    @State private var isLoading = false
    @State private var error: Error?
    @State private var pokemon: Pokemon?
    @State private var isOffline: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                if networkManager.isConnected {
                    if isLoading {
                        ProgressView()
                    } else if let pokemon = pokemon {
                        PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(pokemonService: PokemonService(networkService: NetworkService())), pokemonService: PokemonService(networkService: NetworkService())))
                            .navigationTitle("PokemonApp")
                    } else if let error = error {
                        Text("Error: \(error.localizedDescription)")
                    } else {
                        Text("No data available")
                    }
                }
            }
            .onAppear {
                if networkManager.isConnected {
                    loadData()
                } else {
                    isOffline = true
//                    loadFromCoreData()
                }
            }
//            .alert(isPresented: $isOffline) {
//                Alert(title: Text("Offline"), message: Text("Your app is running in offline mode"), dismissButton: .default(Text("OK")))
//            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func loadData() {
        guard networkManager.isConnected else {
            return
        }
        
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
