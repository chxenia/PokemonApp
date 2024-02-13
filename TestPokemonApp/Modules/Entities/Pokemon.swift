//
//  Pokemon.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import Foundation


struct Pokemon: Codable {
    var name: String
    var url: String
}

struct PokemonInfo: Codable {
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Double
    let height: Double
    
    struct Sprites: Codable {
        let front_default: String?
    }
    
    struct TypeElement: Codable {
        let type: TypeClass
    }

    struct TypeClass: Codable {
        let name: String
    }
}
