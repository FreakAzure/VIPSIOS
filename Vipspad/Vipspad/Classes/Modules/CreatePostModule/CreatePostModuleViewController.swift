//
//  CreatePostModuleViewController.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import UIKit

class CreatePostModuleViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: CreatePostModulePresenter?
    
}

extension CreatePostModuleViewController: PresenterToViewCreatePostModuleProtocol{
    // TODO: Implement View Output Methods
}

// MARK: - UI Setup
extension CreatePostModuleViewController {
    
    private func setupUI() {

    }
    
}
