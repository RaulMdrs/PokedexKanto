//
//  PokemonsCell.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokemonsCell: UITableViewCell {

    @IBOutlet weak var firstPokemonView: UIView!
    @IBOutlet weak var secondPokemonView: UIView!
    @IBOutlet weak var firstPokemonNameLabel: UILabel!
    @IBOutlet weak var secondPokemonNameLabel: UILabel!
    @IBOutlet weak var firstPokemonImage: UIImageView!
    @IBOutlet weak var secondPokemonImage: UIImageView!
    
    func configLayout(pokemon : [PokemonData])
    {
        firstPokemonView.layer.cornerRadius = 18.0
        secondPokemonView.layer.cornerRadius = 18.0
        
        firstPokemonNameLabel.text = pokemon[0].name
        secondPokemonNameLabel.text = pokemon[1].name
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
