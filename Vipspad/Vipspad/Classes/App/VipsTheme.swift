//
//  VipsTheme.swift
//  Vipspad
//
//  Created by Azure on 9/1/23.
//

import Foundation
import UIKit

struct VipsTheme {
    static var Color: VipsColor.Type { VipsColor.self }
    static var Font: VipsFont.Type { VipsFont.self }
}

struct VipsColor {

    /// Generic App Colors
    static var MainColor: UIColor {
        mainColor(force: Singleton.shared.appConfiguration.appMode)
    }
    static var MainColorLight: UIColor {
        mainColorLight(force: Singleton.shared.appConfiguration.appMode)
    }

    /// Background Colors
    static var BackgroundMain: UIColor { .white }
    static var BackgroundGray: UIColor {
        guard let color = R.color.backgroundGray()
        else { fatalError("WebelTheme.BackgroundGray not found") }

        return color
    }
    static var BackgroundGrayDark: UIColor {
        guard let color = R.color.backgroundGrayDark()
        else { fatalError("WebelTheme.BackgroundGrayDark not found") }

        return color
    }
    static var BackgroundGrayLight: UIColor {
        guard let color = .backgroundGrayLight()
        else { fatalError("WebelTheme.BackgroundGrayLight not found") }

        return color
    }
    static var BorderGrayDefault: UIColor {
        guard let color = R.color.borderGrayDefault()
        else { fatalError("WebelTheme.BorderGrayDefault not found") }

        return color
    }
    static var ProgressBarFillColor: UIColor {
        guard let color = R.color.progressBarFillColor()
        else { fatalError("WebelTheme.ProgressBarFillColor not found") }

        return color
    }
    static var BackgroundAlert: UIColor {
        guard let color = R.color.backgroundAlert()
        else { fatalError("WebelTheme.BackgroundAlert not found") }

        return color
    }
    static var BackgroundLightGreen: UIColor {
        guard let color = R.color.lightGreenBackground()
        else { fatalError("WebelTheme.BackgroundLightGreen not found") }

        return color
    }

    /// Font Colors
    static var FontColorMain: UIColor {
        guard let color = R.color.fontColorMain()
        else { fatalError("WebelTheme.FontColorMain not found") }

        return color
    }
    static var FontColorTitles: UIColor {
        guard let color = R.color.fontColorTitles()
        else { fatalError("WebelTheme.FontColorTitles not found") }

        return color
    }
    static var FontColorSecondary: UIColor {
        guard let color = R.color.fontColorSecondary()
        else { fatalError("WebelTheme.FontColorSecondary not found") }

        return color
    }

    static var FontColorAlert: UIColor {
        guard let color = R.color.fontColorAlert()
        else { fatalError("WebelTheme.FontColorAlert not found") }

        return color
    }

    /// Others
    static var PositiveColor: UIColor {
        guard let color = R.color.positiveGreen()
        else { fatalError("WebelTheme.PositiveColor not found") }

        return color
    }
    static var NegativeColor: UIColor {
        guard let color = R.color.negativeColor()
        else { fatalError("WebelTheme.NegativeColor not found") }

        return color
    }
    static var ShadowDefault: UIColor {
        guard let color = R.color.shadowDefault()
        else { fatalError("WebelTheme.ShadowDefault not found") }

        return color
    }

    /// Working Areas Map
    static var WorkAreaBorder: UIColor {
        guard let color = R.color.workAreaBorder()
        else { fatalError("WebelTheme.WorkAreaBorder not found") }

        return color
    }
    static var WorkAreaSelected: UIColor {
        guard let color = R.color.workAreaSelected()
        else { fatalError("WebelTheme.WorkAreaSelected not found") }

        return color
    }
    static var WorkAreaNotSelected: UIColor {
        guard let color = R.color.workAreaNotSelected()
        else { fatalError("WebelTheme.WorkAreaNotSelected not found") }

        return color
    }

    /// Home Backgrounds
    static var HomeTopColor: UIColor {
        guard let color = R.color.homeTopColor()
        else { fatalError("WebelTheme.HomeTopColor not found") }

        return color
    }
    static var HomeBottomColor: UIColor {
        guard let color = R.color.homeBottomColor()
        else { fatalError("WebelTheme.HomeBottomColor not found") }

        return color
    }

    static func mainColor(force appMode: Constants.UserType) -> UIColor {
        guard
            let mainAppProfessional = R.color.mainAppProfessional(),
            let mainAppClient = R.color.mainAppClient()
        else { fatalError("Main app color client or profesisonal not found") }

        return (appMode == .professional) ? mainAppProfessional : mainAppClient
    }
    static func mainColorLight(force appMode: Constants.UserType) -> UIColor {
        guard
            let mainAppProfessionalLight = R.color.mainAppProfessionalLight(),
            let mainAppClientLight = R.color.mainAppClientLight()
        else { fatalError("Main app light color client or profesisonal not found") }

        return (appMode == .professional) ? mainAppProfessionalLight : mainAppClientLight
    }
}

// MARK: - WebelFont

/// Call through WebelTheme
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

