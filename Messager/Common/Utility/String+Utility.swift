//
//  String+Utility.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let emailRegex = "^([A-Z0-9a-z._+-])+@([A-Za-z0-9.-])+\\.([A-Za-z]{2,})$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    func isPassword() -> Bool {
        // At least 10 characters, one half-width uppercase letter, one half-width lowercase letter, one number or one symbol
        let passwordRegex = "^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\\d\\W_])[a-zA-Z\\d\\W_]{10,255}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ debug: DebugLog) {
        for (index, item) in debug.arguments.enumerated() {
            if index != 0 {
                appendLiteral(", ")
            }
            appendLiteral("\(item)")
        }
    }
}
