//
//  WebViewModulePresenter.swift
//  Vipspad
//
//  Created by Azure on 10/1/23.
//  
//

import Foundation

class WebViewModulePresenter: ViewToPresenterWebViewModuleProtocol {
    
    required init(
        view: WebViewModuleViewController,
        interactor: WebViewModuleInteractor,
        router: WebViewModuleRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: WebViewModuleViewController?
    var interactor: WebViewModuleInteractor
    var router: WebViewModuleRouter
    
    
    func viewDidLoad() {}
}

extension WebViewModulePresenter: InteractorToPresenterWebViewModuleProtocol {
    
}
