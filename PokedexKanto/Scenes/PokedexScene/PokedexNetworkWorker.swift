//
//  NetworkWorker.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import Foundation
import Alamofire

public class PokedexNetworkWorker {
    var interactor : PokedexInteractorProtocol?
    func requestPokedex(){
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100") {
            AF.request(url, method: .get).validate().responseDecodable(of: Pokedex.self) {
                response in
                guard let pokedex = response.value else {
                    self.interactor?.nonReceivedPokedex()
                    return }
                self.interactor?.receivedPokedex(pokedex: pokedex)
            }
        }
    }
}

