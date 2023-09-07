//
//  RoundButton.swift
//  Messager
//
//  Created by Kim Phong on 21/06/2023.
//

import Foundation
import UIKit

/// Round Button
class RoundButton: DesignableButton {
    @IBInspectable open var shadowColor: UIColor = .clear
    @IBInspectable open var shadowOffset: CGSize = CGSize(width: 0, height: 5)
    @IBInspectable open var shadowRadius: CGFloat = 5
    @IBInspectable open var shadowOpacity: CGFloat = 0.1
    @IBInspectable open var borderColor: UIColor = .clear
    @IBInspectable open var borderWidth: CGFloat = 1

    override func layoutSubviews() {
        super.layoutSubviews()
        // roundness
        layer.cornerRadius = self.frame.height / 2
        // shadow
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowRadius = shadowRadius
        // border
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
