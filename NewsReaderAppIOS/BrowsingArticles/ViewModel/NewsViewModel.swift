//
//  NewsViewModel.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI
import Combine


protocol NewsViewModelProtocol: ObservableObject {
    var bookmarkedArticles: [Article] { get set }
}
// MARK: - ViewModels
class NewsViewModel: ObservableObject,NewsViewModelProtocol {
    @Published var articles: [Article] = []
    @Published var bookmarkedArticles: [Article] = []
    private var bookmarkService: BookmarkService
    @Published var isLoading: Bool = false
    @State var selectedCategory = Constants.category
    @Published var showNoInternetAlert : Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let newsService: NewsServiceProtocol
    private let networkConnectivityService: NetworkConnectivityProtocol
    
    init(newsService: NewsServiceProtocol,
         networkConnectivityService: NetworkConnectivityProtocol, bookmarkService: BookmarkService = UserDefaultsBookmarkService()){
        self.newsService = newsService
        self.bookmarkService = bookmarkService
        self.networkConnectivityService = networkConnectivityService
        fetchBookmarkedArticles()
        observeNetworkStatus()
    }
    
    
    func fetchNews(category: String){
        guard networkConnectivityService.isConnected.value else {
            showNoInternetAlert = true
            return
        }
        isLoading = true
        newsService.fetchNews(category: category)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &cancellables)
    }
    
    // Fetch bookmarked articles
    func fetchBookmarkedArticles() {
        bookmarkService.fetchBookmarkedArticles()
            .sink { articles in
                self.bookmarkedArticles = articles
            }
            .store(in: &cancellables)
    }
    
    private func observeNetworkStatus() {
        self.networkConnectivityService.isConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isConnected in
                self?.showNoInternetAlert = !isConnected
            }
            .store(in: &cancellables)
    }
    
    func bookmarkArticle(_ article: Article) {
               if !bookmarkedArticles.contains(where: { $0.id == article.id }) {
                    bookmarkedArticles.append(article)
                }
        bookmarkService.saveBookmarkedArticle(article)
        fetchBookmarkedArticles() // Refresh bookmarked articles list
    }
    
    func removeBookmark(_ article: Article) {
        //        bookmarkedArticles.removeAll { $0.id == article.id }
        //        fetchBookmarkedArticles() // Refresh bookmarked articles list
        bookmarkService.removeBookmarkedArticle(article)
        fetchBookmarkedArticles() // Refresh bookmarked articles list
    }
    
    // Add or remove a bookmark
    
    func toggleBookmark(for article: Article) {
        if let index = bookmarkedArticles.firstIndex(where: { $0.id == article.id }) {
            bookmarkedArticles.remove(at: index)
        } else {
            bookmarkedArticles.append(article)
        }
    }
    
    // Check if an article is already bookmarked
    func isBookmarked(_ article: Article) -> Bool {
        return bookmarkedArticles.contains(where: { $0.id == article.id })
    }
    
    private func handleError(_ error: Error) {
        // Handle specific errors with more detailed information
        if let urlError = error as? URLError {
            // Handle URL-related errors (e.g., network failure, timeout)
            switch urlError.code {
            case .notConnectedToInternet:
                showNoInternetAlert = true
            case .timedOut:
                errorMessage = Constants.requestTimedOut
            default:
                errorMessage = Constants.NetworkErrorOccurred
            }
        } else {
            errorMessage = "\(Constants.UnExpectedErrorOccurred) \(error.localizedDescription)"
        }
    }
}
