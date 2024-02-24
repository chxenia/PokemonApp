//
//  Constants.swift
//  TestPokemonApp
//
//  Created by Xenia on 24.02.2024.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://pokeapi.co/api/v2/"
        static let pokemonPath = "pokemon"
        
        static func pokemonURL(forID id: Int) -> URL? {
            var components = URLComponents(string: baseURL)
            components?.path = "\(pokemonPath)/\(id)/"
            return components?.url
        }
    }
    
    struct Error {
        static let invalidURL = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }
}
