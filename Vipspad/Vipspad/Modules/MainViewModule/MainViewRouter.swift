//
//  MainViewRouter.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import Foundation
import UIKit

class MainViewRouter: PresenterToRouterMainViewProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = MainViewViewController()
        
        let interactor = MainViewInteractor()
        
        let presenter = MainViewPresenter(
            view: viewController,
            interactor: interactor,
            router: MainViewRouter()
        )
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
}
