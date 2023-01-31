//
//  CreatePostModulePresenter.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation

class CreatePostModulePresenter: ViewToPresenterCreatePostModuleProtocol {
    
    required init(
        view: CreatePostModuleViewController,
        interactor: CreatePostModuleInteractor,
        router: CreatePostModuleRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: CreatePostModuleViewController?
    var interactor: CreatePostModuleInteractor
    var router: CreatePostModuleRouter
    
    
    func viewDidLoad() {}
}

extension CreatePostModulePresenter: InteractorToPresenterCreatePostModuleProtocol {
    
}
