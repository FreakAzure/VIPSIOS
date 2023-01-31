//
//  HomeModuleRouter.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//  
//

import Foundation
import UIKit

class HomeModuleRouter: PresenterToRouterHomeModuleProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = HomeModuleViewController()
        
        let interactor = HomeModuleInteractor()
        
        let presenter = HomeModulePresenter(
            view: viewController,
            interactor: interactor,
            router: HomeModuleRouter()
        )
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
    func setLoginAsRoot() {
        Navigation.shared.setRoot(LoginRouter.createModule())
    }
    
    func navigateToPosts(_ category: Category) {
        Navigation.shared.push(viewController: PostFeedModuleRouter.createModule(category: category))
    }
    
}
