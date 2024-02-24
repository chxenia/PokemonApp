//
//  Response.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import Foundation
import CoreData

struct Response: Codable{
    var count: Int
    var next: String?
    var previous: String?
    var results: [Pokemon]
}
