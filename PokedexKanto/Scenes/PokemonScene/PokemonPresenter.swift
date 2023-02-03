//
//  PokemonPresenter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import UIKit

class PokemonPresenter {
    var viewController : PokemonVControllerProtocol?
    
    func willShowDetails(numberOfTypes: Int) {
        viewController?.showDetails()
        
        switch numberOfTypes {
        case 1: viewController?.showOneType()
        case 2: viewController?.showTwoTypes()
        default: viewController?.showOneType()
        }
    }
    
    func willSwichImage(data: Data) {
        guard let image = UIImage(data: data) else {return}
        viewController?.swichImage(image: image)
    }
    
    func willShowError(color: UIColor) {
        let error = ModalError()
        error.parent.backgroundColor = color.withAlphaComponent(0.5)
        error.titleLabel.text = "Deu B.O"
        viewController?.showError(error: error)
    }
}
