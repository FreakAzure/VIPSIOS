//
//  File.swift
//  Vipspad
//
//  Created by Azure on 26/1/23.
//

import Foundation
import UIKit

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
}
