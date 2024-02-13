//
//  TestPokemonAppApp.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

@main
struct TestPokemonAppApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonView(presenter: PokemonPresenter(interactor: PokemonInteractor(), view: nil))
        }
    }
}
