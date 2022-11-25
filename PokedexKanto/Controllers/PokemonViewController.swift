//
//  ViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

class PokemonViewController: UIViewController {

    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    var pokedex : Pokedex?
    @IBOutlet weak var pokemonTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokedex(count: 100)
        // Do any additional setup after loading the view.
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
                        print(self.pokedex?.pokemonData)
                        
                        DispatchQueue.main.async{
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
}

extension PokemonViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokedex!.count / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var pokemons : [PokemonData] = []
        pokemons.append(pokedex!.pokemonData[indexPath.row])
        pokemons.append(pokedex!.pokemonData[indexPath.row + 1])
        
        var pokeCell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonsCell
        
        pokeCell.configLayout(pokemon: pokemons)
        
        return pokeCell
    }
}

