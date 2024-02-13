import SwiftUI

struct ContentView: View {
    @ObservedObject var router = PokemonRouter()
    
    var body: some View {
        NavigationView {
            switch router.currentRoute {
            case .home:
                PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(), view: nil), router: router)
                    .navigationTitle("Pokemon Home")
            case .detail(let pokemon):
                DetailView(url: pokemon.url)
                    .navigationTitle(pokemon.name)
                    .navigationBarItems(trailing: Button(action: {
                        router.navigate(to: .home)
                    }, label: {
                        Text("Back to Home")
                    }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
