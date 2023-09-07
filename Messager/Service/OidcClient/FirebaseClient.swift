//
//  FirebaseClient.swift
//  Messager
//
//  Created by Kim Phong on 29/08/2023.
//

import Foundation
import FirebaseAuth

class FirebaseClient: NSObject, OidcClientProtocol {
    typealias AuthStateListener = AuthStateDidChangeListenerHandle
    typealias AuthUser = User

    private static let sharedInstance = FirebaseClient()

    static var `default`: FirebaseClient = sharedInstance

    func addStateDidChangeListener(completionHandler: @escaping (AuthStateListener, AuthUser?) -> Void) {
        var authStateListener: AuthStateListener?
        authStateListener = Auth.auth().addStateDidChangeListener({ auth, user in
            completionHandler(authStateListener!, user)
        })
    }

    func removeStateDidChangeListener(authStateListener: AuthStateListener) {
        Auth.auth().removeStateDidChangeListener(authStateListener)
    }

    func resetPassword(email: String, completionHandler: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                completionHandler(error)
            }
        }
    }

    func sendEmailVerification(completionHandler: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            DispatchQueue.main.async {
                completionHandler(error)
            }
        })
    }

    func signUp(email: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            DispatchQueue.main.async {
                completionHandler(authDataResult?.user.uid, error)
            }
        }
    }

    func signIn(email: String, password: String, completionHandler: @escaping (String?, Bool?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            DispatchQueue.main.async {
                completionHandler(authDataResult?.user.uid, authDataResult?.user.isEmailVerified, error)
            }
        }
    }
}
