//
//  CreatePostModulePresenter.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import Foundation
import UIKit

class CreatePostModulePresenter: ViewToPresenterCreatePostModuleProtocol {
    var networks = [BaseProp]()
    var risks = [BaseProp]()
    var images = [CreatePostModuleViewController.ImageContext: UIImage]()
    var selectedNetwork: BaseProp?
    var selectedRisk: BaseProp?
    
    required init(
        view: CreatePostModuleViewController,
        interactor: CreatePostModuleInteractor,
        router: CreatePostModuleRouter
    )
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Properties
    weak var view: CreatePostModuleViewController?
    var interactor: CreatePostModuleInteractor
    var router: CreatePostModuleRouter
    
    
    func viewDidLoad() {
        self.interactor.retrieveNetworks()
        self.interactor.retrieveRisks()
    }
    
    func riskSelected(_ index: Int) {
        selectedRisk = risks[index]
    }
    
    func networkSelected(_ index: Int) {
        selectedNetwork = networks[index]
    }
    
    func imagePicked(_ image: UIImage, for imageContext: CreatePostModuleViewController.ImageContext) {
        images[imageContext] = image
    }
    
    func createPost(title: String?, body: String?, discordUrl: String?, externalUrl: String?) {
        guard let riskIndex = selectedRisk,
              let networkId = selectedNetwork,
              let imagesArray = [images[.Image1], images[.Image2]] as? [UIImage]
        else {
            view?.showUploadError()
            return
        }
        
        interactor.uploadPost(images: imagesArray, title: title, body: body, riskIndex: String(riskIndex.id), networkId: String(networkId.id), discordUrl: discordUrl, externalUrl: externalUrl)
    }
}

extension CreatePostModulePresenter: InteractorToPresenterCreatePostModuleProtocol {
    func networksRetrieved(networks: [BaseProp]) {
        self.networks = networks
        self.selectedNetwork = self.networks[0]
        guard let vc = view else { return }
        vc.updateNetworks()
    }
    
    func risksRetrieved(risks: [BaseProp]) {
        self.risks = risks
        self.selectedRisk = self.risks[0]
        guard let vc = view else { return }
        vc.updateRisks()
    }
    
    func postUploaded() {
        guard let vc = view else { return }
        vc.postUploaded()
    }
    
    func postUploadFailed() {
        guard let vc = view else { return }
        vc.showUploadError()
    }
}
