//
//  DesignableButton.swift
//  Messager
//
//  Created by Kim Phong on 21/06/2023.
//

import Foundation
import UIKit

/// Make Parameters of designing tool like Figma, Adobe XD, ... on xib for Button
open class DesignableButton: UIButton {
    /// Title characters spacing
    @IBInspectable open var dTitleKern: CGFloat = 0 {
        didSet { updateAttributes() }
    }

    /// Title line spacing
    @IBInspectable open var dTitleLineSpacing: CGFloat = 0 {
        didSet { updateAttributes() }
    }

    private func updateAttributes() {
        if let titleLabel = titleLabel {
            let attributedText = titleLabel.attributedText ?? NSAttributedString(string: titleLabel.text!)
            titleLabel.attributedText = attributedText.designed(for: titleLabel.font,
                                                                textAlignment: titleLabel.textAlignment,
                                                                dKern: dTitleKern,
                                                                dLineSpacing: dTitleLineSpacing)
        }
    }
}
