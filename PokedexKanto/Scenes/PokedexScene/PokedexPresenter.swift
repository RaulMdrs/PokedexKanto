//
//  PokedexPresenter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import Foundation

class PokedexPresenter{
    var viewController : PokedexViewControllerProtocol?
    
    func willShowPokedex() {
        viewController?.showPokedex()
    }
}


