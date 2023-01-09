//
//  MainViewRouter.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import Foundation
import UIKit

class LoginRouter: PresenterToRouterLoginProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = LoginViewController()
        
        let interactor = LoginInteractor()
        
        let presenter = LoginPresenter(
            view: viewController,
            interactor: interactor,
            router: LoginRouter()
        )
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
}
