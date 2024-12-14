//
//  NetworkConnectivityService.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import Foundation
import Network
import Combine

protocol NetworkConnectivityProtocol {
    var isConnected: CurrentValueSubject<Bool, Never> { get }
    func startMonitoring()
    func stopMonitoring()
}

class NetworkConnectivityService: NetworkConnectivityProtocol {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: Constants.NetworkMonitor)
    var isConnected = CurrentValueSubject<Bool, Never>(true)
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected.send(path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
