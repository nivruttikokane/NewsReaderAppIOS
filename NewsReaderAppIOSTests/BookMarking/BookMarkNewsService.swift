//
//  BookMarkNewsService.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 14/12/24.
//

import XCTest
import SwiftUI
import Combine
@testable import NewsReaderAppIOS


// Mock Services
class MockBookmarkService: BookmarkService {
    private var mockBookmarkedArticles: [Article] = []

    func fetchBookmarkedArticles() -> AnyPublisher<[Article], Never> {
        return Just(mockBookmarkedArticles).eraseToAnyPublisher()
    }

    func saveBookmarkedArticle(_ article: Article) {
        mockBookmarkedArticles.append(article)
    }

    func removeBookmarkedArticle(_ article: Article) {
        mockBookmarkedArticles.removeAll { $0.id == article.id }
    }
}

class MockNetworkConnectivityService: NetworkConnectivityProtocol {
    var isConnected = CurrentValueSubject<Bool, Never>(true)

    func startMonitoring() {}
    func stopMonitoring() {}
}

// Mock ViewModel
class MockNewsViewModel: NewsViewModelProtocol {
    @Published var bookmarkedArticles: [Article] = []

    func fetchBookmarkedArticles() {}
}
