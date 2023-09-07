//
//  Constants.swift
//  Messager
//
//  Created by Kim Phong on 16/06/2023.
//

import Foundation

struct Config {
    //
}

enum GlobalSettings {
    static var userDefaults = UserDefaults.standard

    @UserDefault(userDefaults: userDefaults, key: "userStatus", defaultValue: 0)
    static var userStatus: Int

    @UserDefault(userDefaults: userDefaults, key: "emailAddress", defaultValue: "")
    static var emailAddress: String
}

struct Message {
    static let failRegistration = "New account registration failed."
    static let failGetUserInfo = "Failed to get user data. Please try again later."
    static let invalidEmail = "The email address format is incorrect."
    static let invalidPassword = "The password must be has at least 10 characters, 1 uppercase letter, 1 lowercase letter, 1 number and 1 symbol."
    static let newPasswordMismatch = "The new passwords do not match."
    static let successSendVerificationEmail = "Verification email sent."
    static let successSendResetPasswordLink = "Link to reset password is sent to email."
    static let warningVerifyEmail = "Please check email to verify account."
    static let warningRequireEmail = "Email Text Field is required."
}

public func log(_ items: Any..., function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
    var fileName = file
    if let match = fileName.range(of: "[^/]*$", options: .regularExpression) {
        fileName = String(fileName[match])
    }
    let log = "\(Date().format())\(fileName)(L\(line) - \(function): \(DebugLog(items))"

    print("---------------------------------------------------")
    print(log)
    print("---------------------------------------------------")
    #endif
}

class DebugLog {
    var arguments: [Any]
    init(_ items: [Any]) {
        self.arguments = items
    }
}
