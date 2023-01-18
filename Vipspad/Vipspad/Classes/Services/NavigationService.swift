//
//  NavigationService.swift
//  Vipspad
//
//  Created by Azure on 18/1/23.
//

import Foundation
import UIKit

class Navigation {
    static let shared = Navigation()
    
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func push(viewController: UIViewController, animated: Bool = true ) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func setRoot(_ viewController: UIViewController, animated  : Bool = false) {
        navigationController.setViewControllers([viewController], animated: animated)
    }
}
