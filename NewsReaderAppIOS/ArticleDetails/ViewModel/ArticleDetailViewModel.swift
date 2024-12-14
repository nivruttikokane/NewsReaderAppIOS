//
//  ArticleDetailViewModel.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 14/12/24.
//
import SwiftUI
import Combine

// ViewModel for ArticleDetailView
class ArticleDetailViewModel: ObservableObject {
    @Published var article: Article
    @Published var formattedDate: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(article: Article) {
        self.article = article
        formatPublishedDate()
    }
    
    func formatPublishedDate() {
        if let publishedAt = article.publishedAt {
            formattedDate = convertDDMMYYYFormat(dateString: publishedAt)
        }
    }
    
    private func convertDDMMYYYFormat(dateString : String)->String?{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
