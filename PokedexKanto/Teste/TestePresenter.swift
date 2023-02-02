//
//  TestePresenter.swift
//  PokedexKanto
//
//  Created by Raul de Medeiros on 31/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TestePresentationLogic
{
  func presentSomething(response: Teste.Something.Response)
}

class TestePresenter: TestePresentationLogic
{
  weak var viewController: TesteDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Teste.Something.Response)
  {
    let viewModel = Teste.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}