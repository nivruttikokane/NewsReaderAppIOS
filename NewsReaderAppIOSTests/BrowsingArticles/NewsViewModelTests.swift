//
//  NewsViewModelTests.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import XCTest
import Combine
@testable import NewsReaderAppIOS

class NewsViewModelTests: XCTestCase {
    var viewModel: NewsViewModel!
    var mockService: MockNewsService!
    var networkConnectivityProtocol = NetworkConnectivityService()
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
        viewModel = NewsViewModel(newsService: mockService, networkConnectivityService: networkConnectivityProtocol)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchNews() {
        let expectation = self.expectation(description: "Fetch and update articles")

       // viewModel.fetchNews(category: "general")

        // Mock the network call delay if needed
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.fetchNews(category: "general")
        }
        
        viewModel.$articles
            .dropFirst()
            .sink { articles in
                XCTAssertEqual(articles.count, 2, "Expected 2 mock articles")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testBookmarkArticle() {
        let source = Source(id: "id", name: "name")
        let article = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")
        viewModel.bookmarkArticle(article)

        XCTAssertTrue(
                viewModel.bookmarkedArticles.contains(where: { $0.url == article.url }),
                "Article should be bookmarked"
            )
    }

    func testRemoveBookmark() {
        let source = Source(id: "id", name: "name")
        let article = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")
        viewModel.bookmarkArticle(article)
        viewModel.removeBookmark(article)

        XCTAssertFalse(viewModel.bookmarkedArticles.contains(article), "Article should be removed from bookmarks")
    }

    func testErrorHandling() {
        mockService.shouldReturnError = true

        let expectation = self.expectation(description: "Error message updated")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewModel.fetchNews(category: "general")
        }

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage, "Error message should not be nil")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }
}


