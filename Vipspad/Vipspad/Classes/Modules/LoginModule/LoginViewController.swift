//
//  MainViewViewController.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//  
//

import UIKit

class LoginViewController: UIViewController {
    
    @objc func launchWebView() {
        presenter?.launchWebView()
    }

    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "vips_login_bg")
        return imageView
    } ()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "discord_round")?.resizeImageTo(size: CGSize(width: 35, height: 35))
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 32)
        button.setTitle("LOGIN WITH DISCORD", for: .normal)
        button.titleLabel?.font = VipsFont.getFont(.large, .bold)
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor(named: "vips_yellow")
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(launchWebView), for: .touchUpInside)
        return button
    } ()
        
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
        self.view.addSubview(background)
        self.view.addSubview(loginButton)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: loginButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -40).isActive = true
        NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
    }
}
