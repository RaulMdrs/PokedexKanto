//
//  PokemonInteractor.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import Foundation
import UIKit

protocol PokemonInteractorProtocol {
    func receivedPokemon(pokemonDetails : PokemonDetails)
    func nonReceived(error: String)
    func setImage(data: Data)
}

class PokemonInteractor {
    var pokemon : PokemonData?
    var isShiny : Bool = true {
        didSet {
            switchShiny()
        }
    }

    var presenter : PokemonPresenter?
    var workerNetwork : PokemonNetworkWorker?
    
    func requestPokemon() {
        guard let url = pokemon?.url else {return}
        workerNetwork = PokemonNetworkWorker()
        workerNetwork?.interactor = self
        workerNetwork?.getPokemonDetails(pokemonURL: url)
    }
    
    func switchShiny() {
        guard let pokemonID = pokemon?.id else {return}
        workerNetwork = PokemonNetworkWorker()
        workerNetwork?.interactor = self
        if !isShiny {
            workerNetwork?.getImage(url: ApiPath.getPokemonImage(pokemonID: pokemonID))
        } else {
            workerNetwork?.getImage(url: ApiPath.getPokemonShinyImage(pokemonID: pokemonID))
        }
    }
}

extension PokemonInteractor : PokemonInteractorProtocol {
    func nonReceived(error: String) {
        presenter?.willShowError(color: .red)
    }
    
    
    func receivedPokemon(pokemonDetails: PokemonDetails) {
        pokemon?.pokemonDetail = pokemonDetails
        presenter?.willShowDetails(numberOfTypes: self.pokemon?.pokemonDetail?.types.count ?? 1)
    }
    
    func setImage(data: Data) {
        presenter?.willSwichImage(data: data)
    }
}
