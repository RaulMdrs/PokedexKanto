//
//  TesteInteractor.swift
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

protocol TesteBusinessLogic
{
  func doSomething(request: Teste.Something.Request)
}

protocol TesteDataStore
{
  //var name: String { get set }
}

class TesteInteractor: TesteBusinessLogic, TesteDataStore
{
  var presenter: TestePresentationLogic?
  var worker: TesteWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Teste.Something.Request)
  {
    worker = TesteWorker()
    worker?.doSomeWork()
    
    let response = Teste.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
