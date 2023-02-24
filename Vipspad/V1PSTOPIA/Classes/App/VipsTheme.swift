//
//  VipsTheme.swift
//  Vipspad
//
//  Created by Azure on 10/1/23.
//

import Foundation
import UIKit


struct VipsFont {

    enum FontSize: CGFloat {
        /// ExtraSmall -> 10
        case extraSmall = 10
        /// Small -> 12
        case small = 12
        /// Standard -> 14
        case standard = 14
        /// Large -> 16
        case large = 16
        /// ExtraLarge -> 18
        case extraLarge = 18

        /// Title -> 26
        case title = 26
        case custom = -1
    }

    enum FontType: String {
        case thin = "Thin"
        case light = "Light"
        case regular = "Regular"
        case medium = "Medium"
        case semibold = "SemiBold"
        case bold = "Bold"
        case italic = "Italic"
    }

    static func getFont(_ size: FontSize, customSize: CGFloat = -1, _ style: FontType = .regular) -> UIFont {
        switch style {
            case .thin:
                return UIFont.systemFont(
                    ofSize: size != .custom ? size.rawValue : customSize,
                    weight: .thin)
            case .light:
                return UIFont.systemFont(
                    ofSize: size != .custom ? size.rawValue : customSize,
                    weight: .light)
            case .medium:
                return UIFont.systemFont(
                    ofSize: size != .custom ? size.rawValue : customSize,
                    weight: .medium)
            case .semibold:
                return UIFont.systemFont(
                    ofSize: size != .custom ? size.rawValue : customSize,
                    weight: .semibold)
            case .bold:
                return UIFont.systemFont(
                    ofSize: size != .custom ? size.rawValue : customSize,
                    weight: .bold)
            case .italic:
                return UIFont.italicSystemFont(
                    ofSize: size != .custom ? size.rawValue : customSize
                )
            default:
                return UIFont.systemFont(
                    ofSize: size != .custom ? size.rawValue : customSize,
                    weight: .regular)
        }
    }
}
