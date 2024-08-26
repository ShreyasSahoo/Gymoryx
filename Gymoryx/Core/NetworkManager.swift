//
//  NetworkManager.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import Foundation
import Network

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private(set) var isConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
