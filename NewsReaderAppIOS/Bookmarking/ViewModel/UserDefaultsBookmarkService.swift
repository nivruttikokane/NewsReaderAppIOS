//
//  BookmarkService.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import Foundation
import Combine

protocol BookmarkService {
    func fetchBookmarkedArticles() -> AnyPublisher<[Article], Never>
    func saveBookmarkedArticle(_ article: Article)
    func removeBookmarkedArticle(_ article: Article)
}

class UserDefaultsBookmarkService: BookmarkService {
    
    private let bookmarksKey = "bookmarked_articles"
    
    func fetchBookmarkedArticles() -> AnyPublisher<[Article], Never> {
        let bookmarks = loadBookmarkedArticles()
        return Just(bookmarks).eraseToAnyPublisher()
    }
    
    func saveBookmarkedArticle(_ article: Article) {
        var currentBookmarks = loadBookmarkedArticles()
        if !currentBookmarks.contains(article) {
            currentBookmarks.append(article)
            saveBookmarkedArticles(currentBookmarks)
        }
    }
    
    func removeBookmarkedArticle(_ article: Article) {
        var currentBookmarks = loadBookmarkedArticles()
        currentBookmarks.removeAll { $0.id == article.id }
        saveBookmarkedArticles(currentBookmarks)
    }
    
    private func loadBookmarkedArticles() -> [Article] {
        if let data = UserDefaults.standard.data(forKey: bookmarksKey),
           let articles = try? JSONDecoder().decode([Article].self, from: data) {
            return articles
        }
        return []
    }
    
    private func saveBookmarkedArticles(_ articles: [Article]) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: bookmarksKey)
        }
    }
}
