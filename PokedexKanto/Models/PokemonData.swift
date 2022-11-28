//
//  PokemonData.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import Foundation


struct PokemonData : Codable{
    let name : String
    let url : String
    var id : String {
        FindIDPokemon.FindID(url)
    }
    var imageUrl : String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
