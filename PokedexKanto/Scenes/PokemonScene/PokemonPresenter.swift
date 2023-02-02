//
//  PokemonPresenter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import UIKit

class PokemonPresenter {
    var viewController : PokemonVControllerProtocol?
    
    func willShowDetails() {
        viewController?.showDetails()
    }
    
    func willSwichImage(data: Data) {
        guard let image = UIImage(data: data) else {return}
        viewController?.swichImage(image: image)
    }
}
