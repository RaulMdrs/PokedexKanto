//
//  PokedexRouter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import UIKit

protocol PokedexRouterProtocol {
    func goToPokemonDetails(pokemon : PokemonData, navigation : UINavigationController)
}

class PokedexRouter : PokedexRouterProtocol{
    func goToPokemonDetails(pokemon: PokemonData, navigation : UINavigationController) {
        let pokemonStoryboard: UIStoryboard = UIStoryboard(name: "PokemonScreen", bundle: nil)
        
        let pokemonViewController = pokemonStoryboard.instantiateViewController(withIdentifier: "PokemonScreen") as! PokemonViewController
        
        let interactor = PokemonInteractor()
        interactor.pokemon = pokemon
        pokemonViewController.interactor = interactor

        navigation.pushViewController(pokemonViewController, animated: true)
    }
}
