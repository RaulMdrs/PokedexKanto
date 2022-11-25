//
//  Pokedex.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import Foundation

struct Pokedex : Codable{
    var count : Int
    var next : String
    var previous : String?
    var pokemonData : [PokemonData]
    
    private enum CodingKeys : String, CodingKey {
            case count = "count",
                 next = "next",
                 previous = "previous",
                 pokemonData = "results"
        }
}
