//
//  VipsAPIContract.swift
//  Vipspad
//
//  Created by Azure on 8/1/23.
//

import Foundation


struct APICallback<D> {

    /**
     - parameter failure: On  API call failure it returns the error, to the optional implemented failure callback.
                        If failure is not implemented or return false, the error is not handled by the failure function and a generic solution would be used for it
     */

    init(success: @escaping (D) -> Void, failure: @escaping (String) -> Void) {
        self.success = success
        self.failure = failure
    }

    var success: (D) -> Void
    var failure: (String) -> Void

}

protocol APIContract {
    func getSelfData(
        callback: APICallback<User>
    )
    
    func getPostFeed(
        page: Int, category_id: Int,
        callback : APICallback<Posts>
    )
}

struct GetPostsRequest: Encodable {
    let page: Int?
    let category_id: Int
    
}
