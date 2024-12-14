//
//  Article.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import Foundation

nonisolated(unsafe) fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()
// MARK: - Models

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    var id: String {
        return title // You can use title or any unique field as the ID
    }
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var publishedAt: String?
    // let publishedAt: Date
    let content: String?
    
}

struct Source:  Codable {
    let id: String?
    let name: String
}

extension Article: Equatable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id // or whichever properties uniquely identify an article
    }
}
