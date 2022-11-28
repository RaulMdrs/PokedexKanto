//
//  PokemonViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    var pokemon : PokemonData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(pokemon!.name.uppercased())"
        setImage()
    }

    
    func setImage(){
        guard let url = URL(string: pokemon!.imageUrl) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                print(data)
                self.pokemonImage.image = UIImage(data: data)
            }
        }
    }
}
