//
//  BookmarksViewTests.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 14/12/24.
//
import XCTest
import SwiftUI
import Combine
@testable import NewsReaderAppIOS

final class BookmarksViewTests: XCTestCase {
    var mockBookmarkService: MockBookmarkService!
    var mockNetworkService: MockNetworkConnectivityService!
    var mockViewModel: NewsViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockBookmarkService = MockBookmarkService()
        mockNetworkService = MockNetworkConnectivityService()
        mockViewModel = NewsViewModel(
            newsService: MockNewsService(),
            networkConnectivityService: mockNetworkService,
            bookmarkService: mockBookmarkService
        )
        cancellables = []
    }

    override func tearDown() {
        mockBookmarkService = nil
        mockNetworkService = nil
        mockViewModel = nil
        cancellables = nil
        super.tearDown()
    }
    /*
    // To test this test case successfully, make  @State var showAlert = true in BookmarksView
    func testNoBookmarksAlert() {
        // Create an expectation for the alert to be shown
        let expectation = self.expectation(description: "Alert is displayed when there are no bookmarked articles")
        
        // Set the mocked view model's bookmarkedArticles to an empty list
        mockViewModel.bookmarkedArticles = []

        // Create the BookmarksView with the mock view model
        let bookmarksView = BookmarksView(viewModel: mockViewModel)
        bookmarksView.showAlert = true
        // Create a hosting controller to render the view
        let hostingController = UIHostingController(rootView: bookmarksView)

        // Ensure the view is rendered
        XCTAssertNotNil(hostingController.view)

        // Dispatch the UI updates to simulate the view appearing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Verify that the showAlert flag is true when there are no bookmarks
            XCTAssertTrue(bookmarksView.showAlert, "Alert should be shown when no bookmarks are present")
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
*/


    func testBookmarkedArticlesDisplayed() {
        // Test that bookmarked articles are displayed in the list
        let expectation = self.expectation(description: "Bookmarked articles are displayed in the list")

       // let article = Article(id: "1", title: "Test Article", description: nil, content: nil, urlToImage: nil, publishedAt: nil)
        let source = Source(id: "id", name: "name")
        let article = Article(source:source , author: "author", title: "Test Article", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")

        mockBookmarkService.saveBookmarkedArticle(article)
        mockViewModel.fetchBookmarkedArticles()

        mockViewModel.$bookmarkedArticles
            .sink { articles in
                XCTAssertEqual(articles.count, 1, "One bookmarked article should be displayed")
                XCTAssertEqual(articles.first?.title, "Test Article", "The bookmarked article title should match")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testNavigationToArticleDetailView() {
        // Test navigation to the article detail view
        let source = Source(id: "id", name: "name")
        let article = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")
        
        mockBookmarkService.saveBookmarkedArticle(article)
        mockViewModel.fetchBookmarkedArticles()

        let bookmarksView = BookmarksView(viewModel: mockViewModel)
        let hostingController = UIHostingController(rootView: bookmarksView)

        XCTAssertNotNil(hostingController.view) // Ensure the view is rendered

        // Simulate tapping on the article (this would need UI testing for full navigation verification)
        XCTAssertEqual(mockViewModel.bookmarkedArticles.count, 1, "The navigation view should contain one article")
    }
}
