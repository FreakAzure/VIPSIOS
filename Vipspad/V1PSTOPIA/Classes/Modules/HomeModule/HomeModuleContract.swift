//
//  HomeModuleContract.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//  
//

import Foundation


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeModuleProtocol : BaseViperRouter  {
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeModuleProtocol : BaseViperPresenter  {
    
    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeModuleProtocol : BaseViperInteractor  {
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeModuleProtocol : BaseViperPresenter  {
    
}


// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeModuleProtocol : BaseViperViewController {
   
}


/// Optional use situationals

// MARK: Router Input (ParentPresenter -> Presenter)
protocol ParentPresenterToPresenterHomeModuleProtocol : class
{}

// MARK: Router Input (Presenter -> ParentPresenter)
protocol PresenterToParentPresenterHomeModuleProtocol : class
{}

/**
 Exclusive use for entities updates. Avoid as much as possible
 Reference ParentPresenter -> Interactor avoids, having child interactor references into parent interactor. And avoids child presenter have references of entities.
 */
// MARK: Router Input (ParentPresenter -> Interactor)
protocol ParentPresenterToInteractorHomeModuleProtocol : class
{}
