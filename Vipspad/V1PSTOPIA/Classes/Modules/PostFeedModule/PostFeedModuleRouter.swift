//
//  PostFeedModuleRouter.swift
//  Vipspad
//
//  Created by Azure on 28/1/23.
//  
//

import Foundation
import UIKit

class PostFeedModuleRouter: PresenterToRouterPostFeedModuleProtocol {
    
    // MARK: Static methods
    static func createModule(category: Category) -> UIViewController {
        
        let viewController = PostFeedModuleViewController()
        
        let interactor = PostFeedModuleInteractor()
        
        let presenter = PostFeedModulePresenter(
            view: viewController,
            interactor: interactor,
            router: PostFeedModuleRouter()
            )
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.category = category
        
        return viewController
    }
    
}
