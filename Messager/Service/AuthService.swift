//
//  AuthService.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func registerWithEmail(email: String, password: String, success: () -> Void, failure: @escaping (Error?) -> Void )
}

class AuthService: CommonService, AuthServiceProtocol {
    func registerWithEmail(email: String, password: String, success: () -> Void, failure: @escaping (Error?) -> Void) {
        
    }
}
