//
//  UIColor+Utility.swift
//  Messager
//
//  Created by Kim Phong on 16/06/2023.
//

import Foundation
import UIKit

extension UIColor {
    static let buttonDisable = UIColor(named: "ButtonDisable")
    static let lightBlue = UIColor(named: "LightBlue")
    static let lightGray = UIColor(named: "LightGray")
    static let shadow = UIColor(named: "Shadow")
    static let subText = UIColor(named: "SubText")
    static let Text = UIColor(named: "Text")

    /// Return UIColor from hexadecimal of color
    /// - Parameter hex: String
    /// - Returns: UIColor
    static func colorFromHexString(_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
