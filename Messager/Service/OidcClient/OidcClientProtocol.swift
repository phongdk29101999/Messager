//
//  OidcClientProtocol.swift
//  Messager
//
//  Created by Kim Phong on 29/08/2023.
//

import Foundation

// Protocol for the OpenID Connect client
protocol OidcClientProtocol {
    associatedtype AuthStateListener
    associatedtype AuthUser
    func addStateDidChangeListener(completionHandler: @escaping (AuthStateListener, AuthUser?) -> Void)
    func removeStateDidChangeListener(authStateListener: AuthStateListener)
    func resetPassword(email: String, completionHandler: @escaping (Error?) -> Void)
    func sendEmailVerification(completionHandler: @escaping (Error?) -> Void)
    func signIn(email: String, password: String, completionHandler: @escaping (String?, Bool?, Error?) -> Void)
    func signUp(email: String, password: String, completionHandler: @escaping (String?, Error?) -> Void)
}

// MARK: - Type Erasure
// https://qiita.com/omochimetaru/items/5d26b95eb21e022106f0
// Type-erased wrapper for the OpenID Connect client
class AnyOidcClient<AuthStateListener, AuthUser>: OidcClientProtocol {
    private let _addStateDidChangeListener: (@escaping (AuthStateListener, AuthUser?) -> Void) -> Void
    private let _removeStateDidChangeListener: (AuthStateListener) -> Void
    private let _resetPassword: (String, @escaping (Error?) -> Void) -> Void
    private let _sendEmailVerification: (@escaping (Error?) -> Void) -> Void
    private let _signUp: (String, String, @escaping (String?, Error?) -> Void) -> Void
    private let _signIn: (String, String, @escaping (String?, Bool?, Error?) -> Void) -> Void

    init<X: OidcClientProtocol>(_ base: X) where X.AuthStateListener == AuthStateListener, X.AuthUser == AuthUser {
        _addStateDidChangeListener = { base.addStateDidChangeListener(completionHandler: $0) }
        _removeStateDidChangeListener = { base.removeStateDidChangeListener(authStateListener: $0) }
        _resetPassword = { base.resetPassword(email: $0, completionHandler: $1) }
        _sendEmailVerification = { base.sendEmailVerification(completionHandler: $0) }
        _signUp = { base.signUp(email: $0, password: $1, completionHandler: $2) }
        _signIn = { base.signIn(email: $0, password: $1, completionHandler: $2) }
    }

    func addStateDidChangeListener(completionHandler: @escaping (AuthStateListener, AuthUser?) -> Void) {
        _addStateDidChangeListener(completionHandler)
    }

    func removeStateDidChangeListener(authStateListener: AuthStateListener) {
        _removeStateDidChangeListener(authStateListener)
    }

    func resetPassword(email: String, completionHandler: @escaping (Error?) -> Void) {
        _resetPassword(email, completionHandler)
    }

    func sendEmailVerification(completionHandler: @escaping (Error?) -> Void) {
        _sendEmailVerification(completionHandler)
    }

    func signUp(email: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        _signUp(email, password, completionHandler)
    }

    func signIn(email: String, password: String, completionHandler: @escaping (String?, Bool?, Error?) -> Void) {
        _signIn(email, password, completionHandler)
    }
}
