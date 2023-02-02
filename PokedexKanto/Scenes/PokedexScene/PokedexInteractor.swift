//
//  PokedexInteractor.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import Foundation

protocol PokedexInteractorProtocol {
    func receivedPokedex(pokedex : Pokedex)
    func nonReceivedPokedex()
}

class PokedexInteractor : PokedexInteractorProtocol{
    var pokemonsGroup : [Int : [PokemonData]] = [:]
    var presenter : PokedexPresenter?
    var workerNetwork : PokedexNetworkWorker?
    
    func requestPokedex() {
        pokemonsGroup.removeAll()
        workerNetwork = PokedexNetworkWorker()
        workerNetwork?.interactor = self
        workerNetwork?.requestPokedex()
    }
    
    func nonReceivedPokedex() {
       
    }
    
    func receivedPokedex(pokedex: Pokedex) {
        let pokeCount = ((pokedex.pokemonData.count - 1) / 2)
        for n in 0...pokeCount{
            var pokemons : [PokemonData] = []
            pokemons.append(pokedex.pokemonData[n * 2])
            pokemons.append(pokedex.pokemonData[(n * 2) + 1] )
            pokemonsGroup.updateValue(pokemons, forKey: n)
        }
        presenter?.willShowPokedex()
    }
}


// VC solicita para o INTERACTOR que quer receber uma pokedex, INTERACTOR passa o trabalho para o worker de network que irá retornar para o INTERACTOR a informação, com a informação ele vai mandar para o PRESENTER que irá apresentar a informação na VC
