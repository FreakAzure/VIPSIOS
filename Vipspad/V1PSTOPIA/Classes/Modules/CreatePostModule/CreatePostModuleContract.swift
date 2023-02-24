//
//  CreatePostModuleContract.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCreatePostModuleProtocol : BaseViperRouter  {
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCreatePostModuleProtocol : BaseViperPresenter  {
    
    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCreatePostModuleProtocol : BaseViperInteractor  {
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCreatePostModuleProtocol : BaseViperPresenter  {
    
}


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCreatePostModuleProtocol : BaseViperViewController {
   
}


/// Optional use situationals

// MARK: Router Input (ParentPresenter -> Presenter)
protocol ParentPresenterToPresenterCreatePostModuleProtocol : class
{}

// MARK: Router Input (Presenter -> ParentPresenter)
protocol PresenterToParentPresenterCreatePostModuleProtocol : class
{}

/**
 Exclusive use for entities updates. Avoid as much as possible
 Reference ParentPresenter -> Interactor avoids, having child interactor references into parent interactor. And avoids child presenter have references of entities.
 */
// MARK: Router Input (ParentPresenter -> Interactor)
protocol ParentPresenterToInteractorCreatePostModuleProtocol : class
{}
