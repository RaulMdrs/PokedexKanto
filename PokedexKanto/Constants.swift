//
//  Constants.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import Foundation

struct Constants {
    
}

struct ApiPath {
    static let pokedexPath : String = ""
    
    static func getPokemonImage(pokemonID : String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png"
    }
    
    static func getPokemonShinyImage(pokemonID : String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(pokemonID).png"
    }
}
