//
//  ViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

protocol PokedexViewControllerProtocol {
    func showPokedex()
}

extension PokedexViewController : PokedexViewControllerProtocol {
    func showPokedex() {
        pokemonTableView.reloadData()
        hiddeLoader()
    }
}

class PokedexViewController: UIViewController {
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var interactor : PokedexInteractor?
    var router : PokedexRouter?
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
        let router = PokedexRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
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
        router?.goToPokemonDetails(pokemon: gesture.pokemon!, navigation: self.navigationController!)
    }
}

extension PokedexViewController :
    UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.pokemonsGroup.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokeCell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonsCell", for: indexPath) as! PokemonsCell
        pokeCell.configLayout(pokemon: interactor?.pokemonsGroup[indexPath.row] ?? [PokemonData(name: "", url: "")])
        
        let firstGesture = Gesture(target: self, action: #selector(ShowDetailsPokemon(gesture:)))
        firstGesture.pokemon = interactor?.pokemonsGroup[indexPath.row]?.first
        pokeCell.firstPokemonView.addGestureRecognizer(firstGesture)
        pokeCell.firstPokemonView.isUserInteractionEnabled = true
        
        let secondGesture = Gesture(target: self, action: #selector(ShowDetailsPokemon(gesture:)))
        secondGesture.pokemon = interactor?.pokemonsGroup[indexPath.row]?.last
        pokeCell.secondPokemonView.addGestureRecognizer(secondGesture)
        pokeCell.secondPokemonView.isUserInteractionEnabled = true
    
        return pokeCell
    }
    
}

class Gesture : UITapGestureRecognizer{
    var pokemon : PokemonData?
}

