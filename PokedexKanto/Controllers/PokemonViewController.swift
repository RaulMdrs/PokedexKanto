//
//  PokemonViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet var statsLabel: [UILabel]!
    
    var pokemon : PokemonData?
    
    @IBOutlet weak var loaderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPokemon()
        title = "\(pokemon!.name.uppercased())"
        setImage()
    }

    
    func getPokemon(){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon!.id)")
        if let url = url{
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data, error == nil{
                    do{
                        let decoder = JSONDecoder()
                        self.pokemon!.pokemonDetail = try decoder.decode(PokemonDetails.self, from: data)
                        
                        DispatchQueue.main.async{
                            self.setLabels()
                            self.hiddeLoader()
                        }
                    }catch let error {
                        print(error.localizedDescription)
                        print(error)
                    }
                }
            }
            task.resume()
            showLoader()
        }
    }
    
    func setLabels(){
        statsLabel[0].text = String((pokemon!.pokemonDetail?.stats[0].baseStat)!)
        statsLabel[1].text = String((pokemon!.pokemonDetail?.stats[1].baseStat)!)
        statsLabel[2].text = String((pokemon!.pokemonDetail?.stats[2].baseStat)!)
        statsLabel[3].text = String((pokemon!.pokemonDetail?.stats[3].baseStat)!)
        statsLabel[4].text = String((pokemon!.pokemonDetail?.stats[4].baseStat)!)
        statsLabel[5].text = String((pokemon!.pokemonDetail?.stats[5].baseStat)!)
    }
    
    func showLoader()
    {
        loaderView.isHidden = false
        self.view.isUserInteractionEnabled = false
    }
    
    func hiddeLoader(){
        loaderView.isHidden = true
        self.view.isUserInteractionEnabled = true
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
