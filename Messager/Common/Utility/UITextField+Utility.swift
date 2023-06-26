//
//  UITextField+Utility.swift
//  Messager
//
//  Created by Kim Phong on 22/06/2023.
//

import Foundation
import UIKit

extension UITextField {
    func focusNext() -> Bool {
        let nextTag = self.tag + 1
        let nextResponse = self.superview?.viewWithTag(nextTag) as UIResponder?

        if nextResponse != nil {
            nextResponse?.becomeFirstResponder()
            return true
        } else {
            self.resignFirstResponder()
            return false
        }
    }
}

