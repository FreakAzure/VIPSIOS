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

class WebViewModuleViewController: UIViewController	 {
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.setValue("TRUE", forKey: "alwaysRunsAtForegroundPriority");
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
               webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    } ()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        self.loadWebView()
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

        NSLayoutConstraint(item: webView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    func loadWebView() {
        webView.load(URLRequest(url: URL(string: "https://discord.com/api/oauth2/authorize?client_id=1035144996917092392&redirect_uri=https%3A%2F%2Fv1psend-production.up.railway.app%2Fapi%2Fv1%2Fauth%2Fdiscord%2Fredirect%2F&response_type=code&scope=identify%20guilds%20connections%20guilds.members.read")!))
    }
    
}

extension WebViewModuleViewController: WKUIDelegate, WKNavigationDelegate {
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard  let url = self.webView.url else {
            // This should not be possible but still..
            return
        }
        if (url.absoluteString.contains("https://v1psend-production.up.railway.app/")) {
            webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { (raw: Any?, error: Error?) in
                guard let body = raw as? String else {
                    return
                }
                self.presenter?.validateAndSaveToken(body)
                // do stuff
            })
        }
    }
}
