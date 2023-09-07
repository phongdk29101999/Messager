//
//  CommonService.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
}

class CommonService {
    static func encode() -> JSONEncoder {
        let encoder = JSONEncoder()
        return encoder
    }

    static func decode<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(type, from: data)
        } catch {
            log("JSON decode error \(error): \(String(describing: String(data: data, encoding: .utf8)))")

            return nil
        }
    }

    func getFirebaseCollectionReference(_ collectionReference: FCollectionReference) -> CollectionReference {
        Firestore.firestore().collection(collectionReference.rawValue)
    }
}
