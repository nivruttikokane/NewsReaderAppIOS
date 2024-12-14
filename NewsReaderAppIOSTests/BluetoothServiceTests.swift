//
//  BluetoothServiceTests.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import XCTest
import Combine
@testable import NewsReaderAppIOS

class BluetoothServiceTests: XCTestCase {
    var mockService: MockBluetoothService!
    var bluetoothViewModel: BluetoothViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockBluetoothService()
        bluetoothViewModel = BluetoothViewModel(bluetoothService: mockService)
        cancellables = []
    }

    func testArticleSharing() {
        let expectation = self.expectation(description: "Article shared via Bluetooth")
        let source = Source(id: "id", name: "name")
        let testArticle = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")

        bluetoothViewModel.$receivedArticle
            .sink { article in
                if article?.title == testArticle.title {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockService.startAdvertising(article: testArticle)
        waitForExpectations(timeout: 1)
    }
}

class MockBluetoothService: BluetoothServiceProtocol {
    private let subject = PassthroughSubject<Article, Never>()

    func startAdvertising(article: Article) {
        subject.send(article)
    }

    func stopAdvertising() {
        // Mock stop behavior
    }

    func receivedArticles() -> AnyPublisher<Article, Never> {
        subject.eraseToAnyPublisher()
    }
}

