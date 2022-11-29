//
//  PokemonViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var backgroundViewImage: UIView!
    @IBOutlet var typesLabel: [UILabel]!
    @IBOutlet var statsLabel: [UILabel]!
    @IBOutlet weak var getShinyImageView: UIImageView!
    var pokemon : PokemonData?
    var isShiny = false
    @IBOutlet weak var loaderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPokemon()
        title = "\(pokemon!.name)"
        setImage()
    }

    @objc func swichImage(){
        
        if isShiny{
            guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon!.id).png") else { return }
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    print(data)
                    self.pokemonImage.image = UIImage(data: data)
                    self.isShiny = false
                }
            }
        }
        else
        {
            guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(pokemon!.id).png") else { return }
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    print(data)
                    self.pokemonImage.image = UIImage(data: data)
                    self.isShiny = true
                }
            }
        }
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
                        
                        print((self.pokemon?.pokemonDetail?.types[0].type.name)!)
                        DispatchQueue.main.async{
                            self.setLabels()
                            self.setLayout()
                            self.setGesture()
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
    
    func setGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(swichImage))
        getShinyImageView.addGestureRecognizer(gesture)
        getShinyImageView.isUserInteractionEnabled = true
    }
    
    func setLayout(){
        navigationController?.navigationBar.backgroundColor = UIColor(named: self.pokemon!.pokemonDetail!.types[0].type.name)!
        
        getShinyImageView.layer.cornerRadius = 15
        getShinyImageView.layer.masksToBounds = true
        
        let color : UIColor = UIColor(named: self.pokemon!.pokemonDetail!.types[0].type.name)!
        backgroundViewImage.backgroundColor = color.withAlphaComponent(0.8)
        
        if self.pokemon?.pokemonDetail?.types.count == 2{
            print("entrei no count 2")
            
            typesLabel[0].text = self.pokemon!.pokemonDetail!.types[0].type.name
            typesLabel[0].backgroundColor = UIColor(named: (self.pokemon!.pokemonDetail!.types[0].type.name))
            typesLabel[0].isHidden = false
            
            typesLabel[1].text = self.pokemon!.pokemonDetail!.types[1].type.name
            typesLabel[1].backgroundColor = UIColor(named: (self.pokemon!.pokemonDetail!.types[1].type.name))
            typesLabel[1].isHidden = false
            
        }else{
            typesLabel[0].text = self.pokemon!.pokemonDetail!.types[0].type.name
            typesLabel[0].backgroundColor = UIColor(named: (self.pokemon!.pokemonDetail!.types[0].type.name))
            typesLabel[0].isHidden = false
            
            typesLabel[1].text = ""
            typesLabel[1].backgroundColor = .clear
            typesLabel[1].isHidden = true
        }
        typesLabel[0].layer.cornerRadius = 15
        typesLabel[0].layer.masksToBounds = true
        
        typesLabel[1].layer.cornerRadius = 15
        typesLabel[1].layer.masksToBounds = true
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
