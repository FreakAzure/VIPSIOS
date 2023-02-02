//
//  CreatePostModuleInteractor.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation
import UIKit

class CreatePostModuleInteractor: PresenterToInteractorCreatePostModuleProtocol {

    // MARK: Properties
    var presenter: CreatePostModulePresenter?
    
    func retrieveNetworks() {
        AlamofireService.shared.getNetworks(callback: .init(success: { networks in
            self.presenter?.networksRetrieved(networks: networks)
        }, failure: { error in
          print(error)
        }))
    }
    
    func retrieveRisks() {
        AlamofireService.shared.getRisks(callback: .init(success: { risks in
            self.presenter?.risksRetrieved(risks: risks)
        }, failure: { error in
          print(error)
        }))
    }
    
    func uploadPost(images: [UIImage], title: String?, body: String?, riskIndex: String, networkId: String, discordUrl: String?, externalUrl: String?) {
        
        if ( images.count < 2) { self.presenter?.postUploadFailed() }
        guard let title = title, let body = body, let discordUrl = discordUrl, let externalUrl = externalUrl else { self.presenter?.postUploadFailed(); return }
        
        var parameters = [String: String]()
        parameters["title"] = title
        parameters["body"] = body
        parameters["risk_index"] = riskIndex
        parameters["network_id"] = networkId
        parameters["discord_url"] = discordUrl
        parameters["external_url"] = externalUrl
        
        AlamofireService.shared.uploadPost(imagesArray: images, parameters: parameters, callback: .init(success: { _ in
            self.presenter?.postUploaded()
        }, failure: { error in
            self.presenter?.postUploadFailed()
        }))
    }
}
