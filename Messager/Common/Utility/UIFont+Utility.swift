//
//  UIFont+Utility.swift
//  Messager
//
//  Created by Kim Phong on 19/06/2023.
//

import Foundation
import UIKit

extension UIFont {
    convenience init(fontName: FontName, size: CGFloat) {
        self.init(name: fontName.rawValue, size: size)!
    }
}

enum FontName: String {
    case nunitoBold = "Nunito-Bold"
    case nunitoBoldItalic = "Nunito-BoldItalic"
    case nunitoItalic = "Nunito-Italic"
    case nunitoLight = "Nunito-Light"
    case nunitoLightItalic = "Nunito-LightItalic"
    case nunitoMedium = "Nunito-Medium"
    case nunitoMediumItalic = "Nunito-MediumItalic"
    case nunitoRegular = "Nunito-Regular"
    case nunitoSemiBold = "Nunito-SemiBold"
    case nunitoSemiBoldItalic = "Nunito-SemiBoldItalic"
}
