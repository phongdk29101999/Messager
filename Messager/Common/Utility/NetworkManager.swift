//
//  NetworkManager.swift
//  Messager
//
//  Created by Kim Phong on 22/06/2023.
//

import Foundation
import Reachability

class NetworkManager {
    static let shared = NetworkManager()
    private var reachability: Reachability?
    var isNetworkAvaiable: Bool {
        if let reachability = reachability {
            return reachability.connection != .unavailable
        } else {
            return false
        }
    }

    init() {
        reachability = try? Reachability()
        try? reachability?.startNotifier()
    }

    deinit {
        reachability?.stopNotifier()
    }

    func whenReachability(handler: @escaping (Reachability) -> Void) {
        reachability?.whenReachable = { reachability in
            handler(reachability)
        }
    }

    func whenUnReachability(handler: @escaping (Reachability) -> Void) {
        reachability?.whenUnreachable = { reachability in
            handler(reachability)
        }
    }

    func startMonitoring() {
        try? reachability?.startNotifier()
    }

    func stopMonitoring() {
        reachability?.stopNotifier()
    }
}
