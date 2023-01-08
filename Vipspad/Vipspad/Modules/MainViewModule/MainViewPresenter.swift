//
//  MainViewPresenter.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import Foundation

class MainViewPresenter: ViewToPresenterMainViewProtocol {
    
    required init(
        view: MainViewViewController,
        interactor: MainViewInteractor,
        router: MainViewRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: MainViewViewController?
    var interactor: MainViewInteractor
    var router: MainViewRouter
    
    
    func viewDidLoad() {}
}

extension MainViewPresenter: InteractorToPresenterMainViewProtocol {
    
}
