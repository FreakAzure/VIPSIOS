//
//  MainViewContract.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import Foundation


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLoginProtocol : BaseViperRouter  {
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLoginProtocol : BaseViperPresenter  {
    
    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginProtocol : BaseViperInteractor  {
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginProtocol : BaseViperPresenter  {
    
}


// MARK: View Output (Presenter -> View)
protocol PresenterToViewLoginProtocol : BaseViperViewController {
   
}


/// Optional use situationals

// MARK: Router Input (ParentPresenter -> Presenter)
protocol ParentPresenterToPresenterLoginProtocol : class
{}

// MARK: Router Input (Presenter -> ParentPresenter)
protocol PresenterToParentPresenterLoginProtocol : class
{}

/**
 Exclusive use for entities updates. Avoid as much as possible
 Reference ParentPresenter -> Interactor avoids, having child interactor references into parent interactor. And avoids child presenter have references of entities.
 */
// MARK: Router Input (ParentPresenter -> Interactor)
protocol ParentPresenterToInteractorLoginProtocol : class
{}
