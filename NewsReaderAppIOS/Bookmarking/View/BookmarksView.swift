//
//  BookmarksView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//
import SwiftUI

struct BookmarksView: View {
    @ObservedObject var viewModel: NewsViewModel
    @State var showAlert = false

    var body: some View {
        NavigationView {
            List {
                if viewModel.bookmarkedArticles.isEmpty {
                    Text(Constants.NobookmarkedArticlesFound)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .onAppear {
                            showAlert = true // Set alert when the view appears and articles are empty
                        }
                } else {
                    ForEach(viewModel.bookmarkedArticles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            Text(article.title)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle(Constants.Bookmarks)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Constants.NobookmarkedArticlesFound),
                    message: Text(Constants.NobookmarkedArticlesFoundMessaage),
                    dismissButton: .default(Text(Constants.OK))
                )
            }
            .onChange(of: viewModel.bookmarkedArticles.isEmpty) { isEmpty in
                showAlert = isEmpty // Update alert visibility based on the state of bookmarkedArticles
            }
        }
    }
}
