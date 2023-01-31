//
//  CreatePostModuleInteractor.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation

class CreatePostModuleInteractor: PresenterToInteractorCreatePostModuleProtocol {

    // MARK: Properties
    var presenter: CreatePostModulePresenter?
    
    func retrieveNetworks() {
        AlamofireService.shared.getNetworks(callback: .init(success: { networks in
            self.presenter?.networksRetrieved(networks: networks)
        }, failure: { error in
          print(error)
        }))
    }
    
    func retrieveRisks() {
        AlamofireService.shared.getRisks(callback: .init(success: { risks in
            self.presenter?.risksRetrieved(risks: risks)
        }, failure: { error in
          print(error)
        }))
    }
}
