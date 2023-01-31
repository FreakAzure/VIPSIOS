//
//  WebViewModuleRouter.swift
//  Vipspad
//
//  Created by Azure on 10/1/23.
//  
//

import Foundation
import UIKit

class WebViewModuleRouter: PresenterToRouterWebViewModuleProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = WebViewModuleViewController()
        
        let interactor = WebViewModuleInteractor()
        
        let presenter = WebViewModulePresenter(
            view: viewController,
            interactor: interactor,
            router: WebViewModuleRouter()
        )
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
    func setHomeAsRoot() {
        Navigation.shared.setRoot(HomeModuleRouter.createModule())
    }
}
