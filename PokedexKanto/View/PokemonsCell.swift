//
//  PokemonsCell.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokemonsCell: UITableViewCell{
    @IBOutlet weak var firstPokemonView: UIView!
    @IBOutlet weak var secondPokemonView: UIView!
    @IBOutlet weak var firstPokemonNameLabel: UILabel!
    @IBOutlet weak var secondPokemonNameLabel: UILabel!
    @IBOutlet weak var firstPokemonImage: UIImageView!
    @IBOutlet weak var secondPokemonImage: UIImageView!

    
    func configLayout(pokemon : [PokemonData])
    {
        firstPokemonView.layer.cornerRadius = 25.0
        secondPokemonView.layer.cornerRadius = 25.0
        
        firstPokemonNameLabel.text = "#\(pokemon[0].id) \(pokemon[0].name) "
        secondPokemonNameLabel.text = "#\(pokemon[1].id) \(pokemon[1].name)"
        
        setImages(pokemon: pokemon)
    }
    
    func setImages(pokemon : [PokemonData]){
        guard let firstUrl = URL(string: pokemon[0].imageUrl) else { return }
            DispatchQueue.global().async {
                guard let firstData = try? Data(contentsOf: firstUrl) else { return }
                DispatchQueue.main.async {
                    self.firstPokemonImage.image = UIImage(data: firstData)
                }
            }
        
        guard let secondUrl = URL(string: pokemon[1].imageUrl) else {return}
        DispatchQueue.global().async {
            guard let secondData = try? Data(contentsOf: secondUrl) else {return}
            DispatchQueue.main.async {
                self.secondPokemonImage.image = UIImage(data: secondData)
            }
        }
    }
}
