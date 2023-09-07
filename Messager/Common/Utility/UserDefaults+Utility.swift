//
//  UserDefaults+Utility.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation

extension UserDefaults {
    subscript<T: Any>(key: String, defaultValue: T) -> T {
        get {
            let value = object(forKey: key)
            return (value as? T) ?? defaultValue
        }
        set {
            set(newValue, forKey: key)
        }
    }

    subscript<T: Any>(key: String) -> T? {
        get {
            let value = object(forKey: key)
            return value as? T
        }
        set {
            guard let newValue = newValue else {
                removeObject(forKey: key)
                return
            }
            setValue(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct UserDefault<T: Codable> {
    var userDefaults: UserDefaults = UserDefaults.standard
    let key: String
    let defaultValue: T
    var wrappedValue: T {
        get {
            guard let data = userDefaults.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key)
        }
    }
}
