//
//  PokedexPresenter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import Foundation

protocol PokedexPresenterProtocol {
    func willShowPokedex()
}

class PokedexPresenter : PokedexPresenterProtocol{
    var viewController : PokedexViewControllerProtocol?
    
    func willShowPokedex() {
        viewController?.showPokedex()
    }
}


