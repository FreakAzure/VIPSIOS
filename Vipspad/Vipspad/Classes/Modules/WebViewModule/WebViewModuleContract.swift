//
//  WebViewModuleContract.swift
//  Vipspad
//
//  Created by Azure on 10/1/23.
//  
//

import Foundation


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWebViewModuleProtocol : BaseViperRouter  {
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWebViewModuleProtocol : BaseViperPresenter  {
    
    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWebViewModuleProtocol : BaseViperInteractor  {
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWebViewModuleProtocol : BaseViperPresenter  {
    
}


// MARK: View Output (Presenter -> View)
protocol PresenterToViewWebViewModuleProtocol : BaseViperViewController {
   
}


/// Optional use situationals

// MARK: Router Input (ParentPresenter -> Presenter)
protocol ParentPresenterToPresenterWebViewModuleProtocol : class
{}

// MARK: Router Input (Presenter -> ParentPresenter)
protocol PresenterToParentPresenterWebViewModuleProtocol : class
{}

/**
 Exclusive use for entities updates. Avoid as much as possible
 Reference ParentPresenter -> Interactor avoids, having child interactor references into parent interactor. And avoids child presenter have references of entities.
 */
// MARK: Router Input (ParentPresenter -> Interactor)
protocol ParentPresenterToInteractorWebViewModuleProtocol : class
{}
