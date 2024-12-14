//
//  BluetoothService.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI
import Combine
import CoreBluetooth

protocol BluetoothServiceProtocol {
    func startAdvertising(article: Article)
    func stopAdvertising()
    func receivedArticles() -> AnyPublisher<Article, Never>
}


class BluetoothService: NSObject, BluetoothServiceProtocol, CBPeripheralManagerDelegate {
    private var peripheralManager: CBPeripheralManager?
    private let receivedArticlesSubject = PassthroughSubject<Article, Never>()
    private let serviceUUID = CBUUID(string: "1234")
    private let characteristicUUID = CBUUID(string: "5678")
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func startAdvertising(article: Article) {
        guard let data = try? JSONEncoder().encode(article) else { return }
        let characteristic = CBMutableCharacteristic(
            type: characteristicUUID,
            properties: [.read],
            value: data,
            permissions: [.readable]
        )
        let service = CBMutableService(type: serviceUUID, primary: true)
        service.characteristics = [characteristic]
        peripheralManager?.add(service)
        peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
    }
    
    func stopAdvertising() {
        peripheralManager?.stopAdvertising()
    }
    
    func receivedArticles() -> AnyPublisher<Article, Never> {
        receivedArticlesSubject.eraseToAnyPublisher()
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state != .poweredOn {
            print(Constants.Bluetoothisnotpoweredon)
        }
    }
}
