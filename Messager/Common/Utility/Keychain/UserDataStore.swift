//
//  UserDataStore.swift
//  Messager
//
//  Created by Kim Phong on 07/09/2023.
//

import Foundation

public protocol UserDataStore: AnyObject {
    var uuid: String? { get set }
    func removeUserData()
}

