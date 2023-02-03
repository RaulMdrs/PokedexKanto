//
//  ModalError.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 02/02/23.
//

import UIKit

class ModalError: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet var parent: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCustom()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewCustom()
    }
    
    func loadViewCustom() {
        print("entrei aqui")
        Bundle.main.loadNibNamed("ModalError", owner: self)
        parent.frame = bounds
        parent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(parent)
        configLayout()
    }
    
    func configLayout() {
        isHidden = false
    }

    func resetError() {
        self.removeFromSuperview()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        resetError()
    }

}
