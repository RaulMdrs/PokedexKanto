//
//  PokemonDetails.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 28/11/22.
//

import Foundation

struct PokemonDetails : Codable{
    var stats : [Stats]
    var types : [TypePokemon]
}

struct TypePokemon : Codable{
    var type : TypeInfo
}

struct TypeInfo : Codable{
    var name : String
}
