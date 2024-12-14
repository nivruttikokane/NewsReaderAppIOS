//
//  ContentViewTests.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

/*
import XCTest
import ViewInspector
@testable import NewsReaderAppIOS

extension ContentView: Inspectable {}

class ContentViewTests: XCTestCase {
    func testTabViewLabels() throws {
        let contentView = ContentView()
        let tabView = try contentView.inspect().find(ViewType.TabView.self)

        XCTAssertEqual(try tabView.tabItem(at: 0).label().title().string(), "News")
        XCTAssertEqual(try tabView.tabItem(at: 1).label().title().string(), "Bookmarks")
    }

    func testNewsListViewRendering() throws {
        let mockViewModel = NewsViewModel(newsService: MockNewsService())
        let newsListView = NewsListView(viewModel: mockViewModel)

        let list = try newsListView.inspect().find(ViewType.List.self)
        XCTAssertNotNil(list, "List should exist in NewsListView")
    }
}

*/
