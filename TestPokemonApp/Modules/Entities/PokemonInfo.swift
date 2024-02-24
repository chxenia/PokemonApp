//
//  PokemonInfo.swift
//  TestPokemonApp
//
//  Created by Xenia on 14.02.2024.
//

import Foundation
import CoreData

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
