//
//  BluetoothViewModel.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import Combine


class BluetoothViewModel: ObservableObject {
    @Published var receivedArticle: Article?
    private let bluetoothService: BluetoothServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(bluetoothService: BluetoothServiceProtocol) {
        self.bluetoothService = bluetoothService
        setupSubscribers()
    }
    
    func startSharing(article: Article) {
        bluetoothService.startAdvertising(article: article)
    }
    
    func stopSharing() {
        bluetoothService.stopAdvertising()
    }
    
    private func setupSubscribers() {
        bluetoothService.receivedArticles()
            .sink { [weak self] article in
                self?.receivedArticle = article
            }
            .store(in: &cancellables)
    }
}
