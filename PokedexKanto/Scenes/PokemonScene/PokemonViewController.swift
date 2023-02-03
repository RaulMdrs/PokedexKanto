//
//  PokemonViewController.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 25/11/22.
//

import UIKit

protocol PokemonVControllerProtocol {
    func showDetails()
    func swichImage(image: UIImage)
    func showOneType()
    func showTwoTypes()
    func showError(error: ModalError)
}

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var backgroundViewImage: UIView!
    @IBOutlet var typesLabel: [UILabel]!
    @IBOutlet var statsLabel: [UILabel]!
    @IBOutlet weak var getShinyImageView: UIImageView!
    @IBOutlet weak var loaderView: UIView!
    
    var interactor : PokemonInteractor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        interactor?.requestPokemon()

    }

    @objc func swichImagePokemon(){
        interactor?.isShiny = !interactor!.isShiny
    }
       
    private func setupVIP() {
        let viewController = self
        let presenter = PokemonPresenter()

        viewController.interactor = interactor
        self.interactor!.presenter = presenter
        presenter.viewController = viewController
    }
    
    func setLabels(){
        statsLabel[0].text = String((interactor!.pokemon?.pokemonDetail?.stats[0].baseStat)!)
        statsLabel[1].text = String((interactor!.pokemon?.pokemonDetail?.stats[1].baseStat)!)
        statsLabel[2].text = String((interactor!.pokemon?.pokemonDetail?.stats[2].baseStat)!)
        statsLabel[3].text = String((interactor!.pokemon?.pokemonDetail?.stats[3].baseStat)!)
        statsLabel[4].text = String((interactor!.pokemon?.pokemonDetail?.stats[4].baseStat)!)
        statsLabel[5].text = String((interactor!.pokemon?.pokemonDetail?.stats[5].baseStat)!)
    }
    
    func setGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(swichImagePokemon))
        getShinyImageView.addGestureRecognizer(gesture)
        getShinyImageView.isUserInteractionEnabled = true
    }
    
    func setLayout(){
        navigationController?.navigationBar.backgroundColor = UIColor(named: self.interactor!.pokemon?.pokemonDetail!.types[0].type.name ?? "red")!
        
        getShinyImageView.layer.cornerRadius = 15
        getShinyImageView.layer.masksToBounds = true
        
        let color : UIColor = UIColor(named: self.interactor!.pokemon?.pokemonDetail!.types[0].type.name ?? "red")!
        backgroundViewImage.backgroundColor = color.withAlphaComponent(0.8)
        
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
}

extension PokemonViewController : PokemonVControllerProtocol {
    func showError(error: ModalError) {
        error.frame = view.frame
       // let errorr = ModalError(frame: view.frame)
        view.addSubview(error)
    }
    
    func showOneType() {
        typesLabel[0].text = self.interactor!.pokemon?.pokemonDetail!.types[0].type.name
        typesLabel[0].backgroundColor = UIColor(named: (self.interactor!.pokemon?.pokemonDetail!.types[0].type.name)!)
        typesLabel[0].isHidden = false
        
        typesLabel[1].text = ""
        typesLabel[1].backgroundColor = .clear
        typesLabel[1].isHidden = true
    }
    
    func showTwoTypes() {
        typesLabel[0].text = self.interactor!.pokemon?.pokemonDetail!.types[0].type.name
        typesLabel[0].backgroundColor = UIColor(named: (self.interactor!.pokemon?.pokemonDetail!.types[0].type.name)!)
        typesLabel[0].isHidden = false
        
        typesLabel[1].text = self.interactor!.pokemon?.pokemonDetail!.types[1].type.name
        typesLabel[1].backgroundColor = UIColor(named: (self.interactor!.pokemon?.pokemonDetail!.types[1].type.name)!)
        typesLabel[1].isHidden = false
    }
    
    func swichImage(image: UIImage) {
        DispatchQueue.main.async {
            self.pokemonImage.image = image
        }
    }
    
    func showDetails() {
        interactor?.isShiny = false
        setLabels()
        setLayout()
        setGesture()
        hiddeLoader()
        title = "\(interactor!.pokemon!.name)"
    }
}
