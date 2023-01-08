//
//  MainViewViewController.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import UIKit

class MainViewViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: MainViewPresenter?
    
}

extension MainViewViewController: PresenterToViewMainViewProtocol{
    // TODO: Implement View Output Methods
}

// MARK: - UI Setup
extension MainViewViewController {
    
    private func setupUI() {

    }
    
}
