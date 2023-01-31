//
//  HomeModuleInteractor.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//  
//

import Foundation

class HomeModuleInteractor: PresenterToInteractorHomeModuleProtocol {

    // MARK: Properties
    var presenter: HomeModulePresenter?
    
    func retrieveUserData() {
        AlamofireService.shared.getSelfData(callback: APICallback(success: { user in
            Singleton.shared.user = user
            self.presenter?.setUpToolbar()
        }, failure: { error in
           print(error)
        }))
    }
    
    func retrieveCategories() {
        AlamofireService.shared.getCategories(callback: .init(success: {  (categorires: Categories) -> Void  in
            self.presenter?.categoriesRetrieved(categorires)
        }, failure: { error in
            print(error)
        }))
    }
}
