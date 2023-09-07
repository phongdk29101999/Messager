//
//  KeychainWrapper.swift
//  Messager
//
//  Created by Kim Phong on 07/09/2023.
//

import Foundation
import KeychainAccess

class KeychainWrapper {
    static let defaultServiceName = Bundle.main.bundleIdentifier!
    private let keychain: Keychain

    init(serviceName: String = defaultServiceName) {
        keychain = Keychain(service: serviceName)
    }
}

extension KeychainWrapper: UserDataStore {
    var uuid: String? {
        get {
            return keychain[.uuid]
        }
        set {
            keychain[.uuid] = newValue
        }
    }

    func removeUserData() {
        keychain[.uuid] = nil
    }
}

private extension KeychainAccess.Keychain {
    subscript(key: KeychainKey) -> String? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }

    subscript(data key: KeychainKey) -> Data? {
        get {
            return self[data: key.rawValue]
        }
        set {
            self[data: key.rawValue] = newValue
        }
    }
}

private enum KeychainKey: String {
    case uuid
}
