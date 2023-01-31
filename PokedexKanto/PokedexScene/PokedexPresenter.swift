//
//  PokedexPresenter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import Foundation

protocol PokedexPresenterProtocol {
    func willShowPokedex(pokedex : Pokedex)
}

class PokedexPresenter : PokedexPresenterProtocol{
    weak var viewController : PokedexViewControllerProtocol?
    
    
    func willShowPokedex(pokedex : Pokedex) {
        viewController?.showPokedex(pokedex: pokedex)
        
        
    }
}

