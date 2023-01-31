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
    var presenter : PokedexPresenter?
    var workerNetwork : PokedexNetworkWorker?
    
    func requestPokedex() {
        print("requestPokedex")
        workerNetwork = PokedexNetworkWorker()
        workerNetwork?.interactor = self
        workerNetwork?.requestPokedex()
    }
    
    func nonReceivedPokedex() {
        print("nonReceived")
       // presenter. vai chamar o presenter para mostrar erro
    }
    
    func receivedPokedex(pokedex: Pokedex) {
        print("receivedPokedex")
        presenter?.willShowPokedex(pokedex: pokedex)
    }
}



// VC solicita para o INTERACTOR que quer receber uma pokedex, INTERACTOR passa o trabalho para o worker de network que irá retornar para o INTERACTOR a informação, com a informação ele vai mandar para o PRESENTER que irá apresentar a informação na VC
