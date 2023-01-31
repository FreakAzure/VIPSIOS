//
//  PostFeedModuleInteractor.swift
//  Vipspad
//
//  Created by Azure on 28/1/23.
//  
//

import Foundation

class PostFeedModuleInteractor: PresenterToInteractorPostFeedModuleProtocol {

    // MARK: Properties
    var presenter: PostFeedModulePresenter?

    func retrievePosts(categoryId: Int) {
        AlamofireService.shared.getPostFeed(page: 0, category_id: categoryId, callback: .init(success: { posts in
            self.presenter?.loadPosts(posts)
        }, failure: { error in
            print(error)
        }))
    }
}

