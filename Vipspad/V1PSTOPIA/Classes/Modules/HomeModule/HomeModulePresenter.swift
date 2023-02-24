//
//  HomeModulePresenter.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//  
//

import Foundation

class HomeModulePresenter: ViewToPresenterHomeModuleProtocol {
    
    func viewDidLoad() {
        
    }
    
    
    var categories = Categories()
    
    required init(
        view: HomeModuleViewController,
        interactor: HomeModuleInteractor,
        router: HomeModuleRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: HomeModuleViewController?
    var interactor: HomeModuleInteractor
    var router: HomeModuleRouter
    
    
    func viewWillLoad() {
        interactor.retrieveUserData()
        interactor.retrieveCategories()
    }
    
    func updateCategories() {
        interactor.retrieveCategories()
    }
    
    func navigateToCreatePost() {
        self.router.navigateToCreatePost()
    }
    
    func logout() {
        self.interactor.logOut()
    }
}

extension HomeModulePresenter: InteractorToPresenterHomeModuleProtocol {
    func setUpToolbar() {
        guard let vc = view, let user = Singleton.shared.user else { return }
        vc.setupToolbar(userImage: user.photoURL)
    }
    
    func categoriesRetrieved(_ categories: Categories) {
        self.categories.removeAll()
        self.categories.append(contentsOf: categories)
        self.view?.reloadTable()
    }
    
    func navigateToPostFeed(_ category: Category) {
        router.navigateToPosts(category)
    }
    
    func setLoginAsRoot() {
        router.setLoginAsRoot()
    }
}
