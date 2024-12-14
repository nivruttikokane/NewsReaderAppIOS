//
//  ArticleDetailViewTests.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 14/12/24.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NewsReaderAppIOS
/*
class ArticleDetailViewTests: XCTestCase {
    
    var article: Article!
    var view: ArticleDetailView!
    
    override func setUp() {
        super.setUp()
        let source = Source(id: "id", name: "name")
        let article = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")
        
        view = ArticleDetailView(article: article)
    }
    
    override func tearDown() {
        article = nil
        view = nil
        super.tearDown()
    }
    
    
    func testTitleRendering() throws {
        let inspectedView = try view.inspect()
        let titleText = try inspectedView.scrollView().vStack().text(0).string()
        XCTAssertEqual(titleText, "Test Article")
    }
    func testDescriptionRendering() throws {
        let inspectedView = try view.inspect()
        let descriptionText = try inspectedView.scrollView().vStack().text(1).string()
        XCTAssertEqual(descriptionText, "This is a test description.")
    }
    /*
    func testImageLoadingPlaceholder() throws {
        article = Article(
            title: "Test Article",
            description: "This is a test description.",
            url: "https://example.com/invalid-url.jpg",
            urlToImage: "https://example.com/invalid-url.jpg",
            publishedAt: nil,
            content: "This is the full content of the article."
        )
        let source = Source(id: "id", name: "name")
        let article = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", content: "content")
        view = ArticleDetailView(article: article)

        // Inspect the view
        let inspectedView = try view.inspect()
        let asyncImage = try inspectedView.scrollView().vStack().view(AsyncImage<EmptyView>.self, 0)

        // Check for the placeholder state (ProgressView)
        XCTAssertNoThrow(try asyncImage.hStack().progressView(0))
    }
*/
    func testDateFormatting() throws {
        let inspectedView = try view.inspect()
        let dateText = try inspectedView.scrollView().vStack().text(2).string()
        XCTAssertEqual(dateText, "12/12/2024") // Assuming `convertDDMMYYYFormat` outputs this format
    }
    func testContentRendering() throws {
        let inspectedView = try view.inspect()
        let contentText = try inspectedView.scrollView().vStack().text(3).string()
        XCTAssertEqual(contentText, "This is the full content of the article.")
    }
   /* func testOptionalProperties() throws {
        // Test case where description and image are nil
//        article = Article(
//            title: "Test Article",
//            description: nil,
//            url: "",
//            urlToImage: nil,
//            publishedAt: nil,
//            content: nil
//        )
        let source = Source(id: "id", name: "name")
       // let article = Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", content: "content")
        
        let article = Article(source: source, author: "author", title: "title", description: nil, url: "", urlToImage: nil, publishedAt: nil, content: nil)
        view = ArticleDetailView(article: article)
        
        let inspectedView = try view.inspect()
        XCTAssertThrowsError(try inspectedView.scrollView().vStack().text(1)) // No description
        XCTAssertThrowsError(try inspectedView.scrollView().vStack().view(AsyncImage<EmptyView>.self, 0)) // No image
    }*/
    
    func testOptionalProperties() throws {
        // Test case where description and image are nil
        let source = Source(id: "id", name: "name")
        let article = Article(source: source, author: "author", title: "title", description: nil, url: "", urlToImage: nil, publishedAt: nil, content: nil)
        
        view = ArticleDetailView(article: article)
        
        let inspectedView = try view.inspect()
        
        // Test that the description is not present (throws error)
        XCTAssertThrowsError(try inspectedView.scrollView().vStack().text(1)) // No description
        
        // Test that the image is not present (throws error)
        XCTAssertThrowsError(try inspectedView.scrollView().vStack().view(AsyncImage<EmptyView>.self, 0)) // No image
    }

}
*/

