//
//  ViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit
import Alamofire

protocol PokedexViewControllerProtocol: AnyObject {
    func showPokedex(pokedex: Pokedex)
}

extension PokedexViewController : PokedexViewControllerProtocol {
    func showPokedex(pokedex: Pokedex) {
        print("showPokedex")
        self.pokedex = pokedex
        pokemonTableView.reloadData()
        hiddeLoader()
        

    }
}

class PokedexViewController: UIViewController {
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var pokemonTableView: UITableView!
    var pokedex : Pokedex?
    
    var interactor : PokedexInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        title = "Pokedex"
        pokemonTableView.dataSource = self
        
        interactor?.requestPokedex()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.toolbar.backgroundColor = .red
    }
    
    func setupVIP() {
        let viewController = self
        let interactor = PokedexInteractor()
        let presenter = PokedexPresenter()
        
        viewController.interactor = interactor
       // viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
//        router.viewController = viewController
//        router.dataStore = interactor
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
}

extension PokedexViewController :
    UITableViewDataSource{
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

