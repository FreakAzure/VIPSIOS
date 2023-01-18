//
//  WebViewModuleViewController.swift
//  Vipspad
//
//  Created by Azure on 10/1/23.
//  
//
import Foundation
import WebKit
import UIKit

class WebViewModuleViewController: UIViewController, WKUIDelegate	 {
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
               webView.uiDelegate = self
               view = webView
        return webView
    } ()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: WebViewModulePresenter?
    
}

extension WebViewModuleViewController: PresenterToViewWebViewModuleProtocol{
    // TODO: Implement View Output Methods
}

// MARK: - UI Setup
extension WebViewModuleViewController {
    
    private func setupUI() {
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
}
