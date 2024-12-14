//
//  MockNewsService.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import Combine
@testable import NewsReaderAppIOS
import Foundation


public class MockNewsService: NewsServiceProtocol {
    var shouldReturnError = false
    public func fetchNews(category: String) -> AnyPublisher<[NewsReaderAppIOS.Article], any Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        let source = Source(id: "id", name: "name")
        let mockArticles = [
            Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content"),
            Article(source:source , author: "author", title: "title", description: "description", url: "url", urlToImage: "urlToImage", publishedAt: "publishedAt", content: "content")
        ]
        return Just(mockArticles)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    }
    
  
    
  
