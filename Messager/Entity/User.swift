//
//  User.swift
//  Messager
//
//  Created by Kim Phong on 27/06/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct UserInfo: Codable, Equatable {
    var id: String = ""
    var username: String
    var email: String
    var pushId: String = ""
    var avatarLink: String = ""
    var status: String
//
//    static var currentId: String {
//        Auth.auth().currentUser!.uid
//    }
//
//    static var currentuser: User? {
//        if Auth.auth().currentUser != nil {
//            return GlobalSettings.currentUser
//        }
//        return nil
//    }
//
//    static func ==(lhs: User, rhs: User) -> Bool {
//        lhs.id == rhs.id
//    }
}

enum UserStatus: Int {
    case none = 0
    case preMember = 1
    case member = 2
}
