//
//  MainViewPresenter.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import Foundation

class LoginPresenter: ViewToPresenterLoginProtocol {
    
    required init(
        view: LoginViewController,
        interactor: LoginInteractor,
        router: LoginRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: LoginViewController?
    var interactor: LoginInteractor
    var router: LoginRouter
    
    
    func viewDidLoad() {}
}

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    
}
