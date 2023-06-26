//
//  DesignableLabel.swift
//  Messager
//
//  Created by Kim Phong on 21/06/2023.
//

import Foundation
import UIKit

/// Make Parameters of designing tool like Figma, Adobe XD, ... on xib for Label
open class DesignableLabel: UILabel {
    /// character spacing
    @IBInspectable open var dKern: CGFloat = 0 {
        didSet { updateAttributes() }
    }

    /// line spacing
    @IBInspectable open var dLineSpacing: CGFloat = 0 {
        didSet { updateAttributes() }
    }

    private func updateAttributes() {
        let attributedText = attributedText ?? NSAttributedString(string: text!)
        self.attributedText = attributedText.designed(for: font,
                                                      textAlignment: textAlignment,
                                                      dKern: dKern,
                                                      dLineSpacing: dLineSpacing)
    }
}
