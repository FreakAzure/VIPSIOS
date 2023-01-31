//
//  CreatePostModuleRouter.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation
import UIKit

class CreatePostModuleRouter: PresenterToRouterCreatePostModuleProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = CreatePostModuleViewController()
        
        let interactor = CreatePostModuleInteractor()
        
        let presenter = CreatePostModulePresenter(
            view: viewController,
            interactor: interactor,
            router: CreatePostModuleRouter()
        )
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
}
