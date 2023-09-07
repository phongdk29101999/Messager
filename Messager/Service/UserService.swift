//
//  UserService.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation

protocol UserServiceProtocol {
    func createUser(_ user: UserInfo)
    func getEmailAddress() -> String
    func getUser(userId: String, completion: @escaping (Result<UserInfo, Error>) -> Void)
    func getUuid() -> String?
    func removeUserCaches()
    func saveEmailAddress(_ email: String)
    func saveUserCache(_ user: UserInfo)
    func saveUserStatus(verifiedEmail: Bool)
    func saveUuid(_ uuid: String?)
}

class UserService: CommonService, UserServiceProtocol {
    private let USER_KEY = "CURRENT_USER"

    private var userDataStore: UserDataStore

    init(userDataStore: UserDataStore = KeychainWrapper()) {
        self.userDataStore = userDataStore
    }

    func createUser(_ user: UserInfo) {
        do {
            try getFirebaseCollectionReference(.User).document(user.id).setData(from: user)
        } catch {
            log(error.localizedDescription)
        }
    }

    func getEmailAddress() -> String {
        return GlobalSettings.emailAddress
    }

    func getUser(userId: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        getFirebaseCollectionReference(.User).document(userId).getDocument(as: UserInfo.self) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
                return
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }

    static func getUserStatus() -> Int {
        return GlobalSettings.userStatus
    }

    func getUuid() -> String? {
        userDataStore.uuid
    }

    func removeUserCaches() {
        userDataStore.removeUserData()
        UserDefaults.standard.removeObject(forKey: USER_KEY)
    }

    func saveEmailAddress(_ email: String) {
        GlobalSettings.emailAddress = email
    }

    func saveUserCache(_ user: UserInfo) {
        let encoder = JSONEncoder()

        do {
            let userData = try encoder.encode(user)
            UserDefaults.standard.set(userData, forKey: USER_KEY)
        } catch {
            log("Encode failed")
        }
    }

    func saveUserStatus(verifiedEmail: Bool) {
        if verifiedEmail {
            GlobalSettings.userStatus = UserStatus.member.rawValue
        } else {
            GlobalSettings.userStatus = UserStatus.preMember.rawValue
        }
    }

    func saveUuid(_ uuid: String?) {
        userDataStore.uuid = uuid
    }
}
