//
//  PostFeedModulePresenter.swift
//  Vipspad
//
//  Created by Azure on 28/1/23.
//  
//

import Foundation

class PostFeedModulePresenter: ViewToPresenterPostFeedModuleProtocol {
    
    var category: Category?
    var posts = Posts()
    
    required init(
        view: PostFeedModuleViewController,
        interactor: PostFeedModuleInteractor,
        router: PostFeedModuleRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: PostFeedModuleViewController?
    var interactor: PostFeedModuleInteractor
    var router: PostFeedModuleRouter
    
    
    func viewDidLoad() {
        guard let categoryId = category?.id else {return}
        interactor.retrievePosts(categoryId: categoryId)
    }
    
    func deletePost(postId: Int) {
        interactor.deletePosts(postId: postId)
    }
}

extension PostFeedModulePresenter: InteractorToPresenterPostFeedModuleProtocol {
    func loadPosts(_ posts: Posts) {
        self.posts = posts
        guard let vc = self.view as? PostFeedModuleViewController else {return}
        if posts.isEmpty {
            vc.exitView()
        }
        vc.reloadTableView()
    }
    
    func postDeleted() {
        guard let categoryId = category?.id else {return}
        interactor.retrievePosts(categoryId: categoryId)
    }
}
