//
//  PokemonInteractor.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import Foundation

protocol PokemonInteractorProtocol {
    func receivedPokemon(pokemonDetails : PokemonDetails)
    func nonReceived()
    func swichShiny(data: Data)
}

class PokemonInteractor {
    var pokemon : PokemonData?
    var isShiny : Bool = false

    var presenter : PokemonPresenter?
    var workerNetwork : PokemonNetworkWorker?
    
    func requestPokemon() {
        print("chamou request pro network")
       // print(pokemon?.name)
        guard let url = pokemon?.url else {return}
        workerNetwork = PokemonNetworkWorker()
        workerNetwork?.interactor = self
        workerNetwork?.getPokemonDetails(pokemonURL: url)
    }
    
    func swichShiny() {
        guard let pokemonID = pokemon?.id else {return}
        workerNetwork = PokemonNetworkWorker()
        workerNetwork?.interactor = self
        if isShiny {
            isShiny = false
            workerNetwork?.getShinyImage(url: ApiPath.getPokemonImage(pokemonID: pokemonID))
        } else {
            isShiny = true
            workerNetwork?.getShinyImage(url: ApiPath.getPokemonShinyImage(pokemonID: pokemonID))
        }
    }
}

extension PokemonInteractor : PokemonInteractorProtocol {
    
    func receivedPokemon(pokemonDetails: PokemonDetails) {
        pokemon?.pokemonDetail = pokemonDetails
        presenter?.willShowDetails()
    }
    
    func nonReceived() {
        print("algo")
    }
    
    func swichShiny(data: Data) {
        presenter?.willSwichImage(data: data)
    }
}
