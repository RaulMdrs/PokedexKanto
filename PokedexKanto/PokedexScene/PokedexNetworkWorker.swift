//
//  NetworkWorker.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//

import Foundation
import Alamofire

protocol PokedexNetworkWorkerProtocol {
    func requestPokedex()
}

public class PokedexNetworkWorker : PokedexNetworkWorkerProtocol{
    var interactor : PokedexInteractorProtocol?
    func requestPokedex(){
        print("worker chamado")
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100") {
            AF.request(url, method: .get).validate().responseDecodable(of: Pokedex.self) {
                response in
                guard let pokedex = response.value else {return}
                self.interactor?.receivedPokedex(pokedex: pokedex)
            }
        }
    }
}

