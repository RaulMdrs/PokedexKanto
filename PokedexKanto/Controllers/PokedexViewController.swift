//
//  ViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    var pokedex : Pokedex?
    @IBOutlet weak var pokemonTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokedex"
        pokemonTableView.dataSource = self
        getPokedex(count: 101)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.toolbar.backgroundColor = .red
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
    
    @objc func ShowDetailsPokemon(gesture : Gesture){
        print(gesture.pokemon?.name)
        
        let pokemonStoryboard: UIStoryboard = UIStoryboard(name: "PokemonScreen", bundle: nil)
        
        let pokemonViewController = pokemonStoryboard.instantiateViewController(withIdentifier: "PokemonScreen") as! PokemonViewController
        
        pokemonViewController.pokemon = gesture.pokemon

        self.navigationController?.pushViewController(pokemonViewController, animated: true)
    }
    
    
    func getPokedex(count : Int){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(count)")
        if let url = url{
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data, error == nil{
                    do{
                        let decoder = JSONDecoder()
                        self.pokedex = try decoder.decode(Pokedex.self, from: data)
                        print(self.pokedex!.pokemonData[1].imageUrl)
                        
                        DispatchQueue.main.async{
                            self.hiddeLoader()
                            self.pokemonTableView.reloadData()
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
    
    
    
}

extension PokedexViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokedex?.pokemonData.count ?? 0) / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("entrei na config ")
        var pokemons : [PokemonData] = []
        pokemons.append(pokedex!.pokemonData[indexPath.row * 2])
        pokemons.append(pokedex!.pokemonData[(indexPath.row * 2) + 1] )
        let pokeCell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonsCell", for: indexPath) as! PokemonsCell
        
        
        let firstGesture = Gesture(target: self, action: #selector(ShowDetailsPokemon(gesture:)))
        firstGesture.pokemon = pokedex?.pokemonData[indexPath.row * 2]
        pokeCell.firstPokemonView.addGestureRecognizer(firstGesture)
        pokeCell.firstPokemonView.isUserInteractionEnabled = true
        
        let secondGesture = Gesture(target: self, action: #selector(ShowDetailsPokemon(gesture:)))
        secondGesture.pokemon = pokedex?.pokemonData[(indexPath.row * 2) + 1]
        pokeCell.secondPokemonView.addGestureRecognizer(secondGesture)
        pokeCell.secondPokemonView.isUserInteractionEnabled = true
        
        pokeCell.configLayout(pokemon: pokemons)
        
        return pokeCell
    }
    
}

class Gesture : UITapGestureRecognizer{
    var pokemon : PokemonData?
}

