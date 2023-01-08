//
//  MainViewContract.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import Foundation


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainViewProtocol : BaseViperRouter  {
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainViewProtocol : BaseViperPresenter  {
    
    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainViewProtocol : BaseViperInteractor  {
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainViewProtocol : BaseViperPresenter  {
    
}


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainViewProtocol : BaseViperViewController {
   
}


/// Optional use situationals

// MARK: Router Input (ParentPresenter -> Presenter)
protocol ParentPresenterToPresenterMainViewProtocol : class
{}

// MARK: Router Input (Presenter -> ParentPresenter)
protocol PresenterToParentPresenterMainViewProtocol : class
{}

/**
 Exclusive use for entities updates. Avoid as much as possible
 Reference ParentPresenter -> Interactor avoids, having child interactor references into parent interactor. And avoids child presenter have references of entities.
 */
// MARK: Router Input (ParentPresenter -> Interactor)
protocol ParentPresenterToInteractorMainViewProtocol : class
{}
