//
//  FindIDPokemon.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import Foundation

struct FindIDPokemon{
    static func FindID(_ url : String) -> String{
        var id : String = ""
        var count : Int = 0
        
        for letter in url.reversed(){
            if letter == "/"{
                count += 1
            }
            else {
                id.append(letter)
            }
            
            if count == 2{
                break
            }
        }
        return String(id.reversed())
    }
}
