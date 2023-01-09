//
//  MainViewViewController.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var helloText: UILabel = {
        let text = UILabel()
        text.text = "Hello Vips"
        text.sizeToFit()
        text.textColor = .black
        return text
    } ()
    
    private lazy var loginButton
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: LoginPresenter?
    
}

extension LoginViewController: PresenterToViewLoginProtocol{
    // TODO: Implement View Output Methods
}

// MARK: - UI Setup
extension LoginViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .brown
        self.view.addSubview(helloText)
        helloText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: helloText, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: helloText, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
}
