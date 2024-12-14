//
//  NewsServiceTests.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import XCTest
import Combine
@testable import NewsReaderAppIOS

class NewsServiceTests: XCTestCase {
    var newsService: NewsServiceProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        newsService = NewsService()
        cancellables = []
    }

    override func tearDown() {
        newsService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchNewsSuccess() {
        let expectation = self.expectation(description: "Fetch news successfully")

        newsService.fetchNews(category: "general")
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but received failure")
                }
            }, receiveValue: { articles in
                XCTAssertFalse(articles.isEmpty, "Articles should not be empty")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchNewsFailure() {
        let mockService = MockNewsService()
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch news failure")

        mockService.fetchNews(category: "general")
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but received success")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }
}
