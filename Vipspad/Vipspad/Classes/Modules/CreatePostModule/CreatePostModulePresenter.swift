//
//  CreatePostModulePresenter.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation

class CreatePostModulePresenter: ViewToPresenterCreatePostModuleProtocol {
    var networks = [BaseProp]()
    var risks = [BaseProp]()
    
    required init(
        view: CreatePostModuleViewController,
        interactor: CreatePostModuleInteractor,
        router: CreatePostModuleRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: CreatePostModuleViewController?
    var interactor: CreatePostModuleInteractor
    var router: CreatePostModuleRouter
    
    
    func viewDidLoad() {
        self.interactor.retrieveNetworks()
        self.interactor.retrieveRisks()
    }
}

extension CreatePostModulePresenter: InteractorToPresenterCreatePostModuleProtocol {
    func networksRetrieved(networks: [BaseProp]) {
        self.networks = networks
        guard let vc = view else { return }
        vc.updateNetworks()
    }
    
    func risksRetrieved(risks: [BaseProp]) {
        self.risks = risks
        guard let vc = view else { return }
        vc.updateRisks()
    }
}
