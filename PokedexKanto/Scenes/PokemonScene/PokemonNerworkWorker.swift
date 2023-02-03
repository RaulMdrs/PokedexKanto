//
//  PokemonNerworkWorker.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import Foundation
import Alamofire

class PokemonNetworkWorker {
    var interactor : PokemonInteractorProtocol?
    
    func getPokemonDetails(pokemonURL: String) {
        if let url = URL(string: pokemonURL + "a") {
            AF.request(url, method: .get).validate().responseDecodable(of: PokemonDetails.self) {
                response in
                guard let pokemonDetails = response.value else {
                    self.interactor?.nonReceived(error: "aa")
                    return
                }
                self.interactor?.receivedPokemon(pokemonDetails: pokemonDetails)
            }
        }
    }
    
    
    func getImage(url : String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            self.interactor?.setImage(data: data)
        }
    }
}
