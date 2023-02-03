//
//  Stats.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 28/11/22.
//

import Foundation

struct Stats : Codable {
    var baseStat : Int
    var effort : Int
    var stat : StatsInfoUrl
    
    
    private enum CodingKeys : String, CodingKey {
            case baseStat = "base_stat",
                 effort = "effort",
                 stat = "stat"
        }
}
