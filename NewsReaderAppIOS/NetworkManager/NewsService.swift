//
//  NewsService.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import Combine
import Foundation

// MARK: - Network Layer
protocol NewsServiceProtocol {
    func fetchNews(category: String) -> AnyPublisher<[Article], Error>
}

class NewsService : NewsServiceProtocol,ObservableObject{
    
    func fetchNews(category: String) -> AnyPublisher<[Article], Error> {
        let url = URL(string: "\(Constants.baseURL)apiKey=\(Constants.appApiKey)&language=en&category=\(category)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())  // Decode into NewsResponse instead of directly into [Article]
            .map { $0.articles }  // Extract the articles array from the response
            .receive(on: DispatchQueue.main)  // Ensure updates happen on the main thread
            .eraseToAnyPublisher()  // Return the result as a publisher of type AnyPublisher<[Article], Error>
    }
}
