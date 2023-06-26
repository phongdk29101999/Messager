//
//  NSAttributedString+Utility.swift
//  Messager
//
//  Created by Kim Phong on 21/06/2023.
//

import Foundation
import UIKit

extension NSAttributedString {
    func designed(for font: UIFont, textAlignment: NSTextAlignment, dKern: CGFloat = 0, dLineSpacing: CGFloat = 0) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(attributedString: self)
        let rangeText = NSRange(location: 0, length: attributedText.length)
        if dKern > 0 {
            // Note: Key.tracking effects spacing between groups of characters but Key.kern effects spacing betwwen individual characters
            attributedText.addAttribute(NSAttributedString.Key.kern,
                                        value: dKern / 1000 * font.pointSize,
                                        range: rangeText)
        }

        if dLineSpacing > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = dLineSpacing - font.lineHeight
            paragraphStyle.alignment = textAlignment
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: rangeText)
        }

        return attributedText
    }
}
