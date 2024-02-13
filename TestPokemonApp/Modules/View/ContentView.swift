import SwiftUI

struct ContentView: View {
    @ObservedObject var router = PokemonRouter()
    
    var body: some View {
        NavigationView {
            switch router.currentRoute {
            case .home:
                PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(), view: nil), router: router)
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
        .preferredColorScheme(.dark)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
