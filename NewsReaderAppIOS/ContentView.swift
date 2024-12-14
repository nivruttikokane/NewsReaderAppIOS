//
//  ContentView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel(newsService: NewsService(), networkConnectivityService: NetworkConnectivityService(), bookmarkService: UserDefaultsBookmarkService())
    
    var body: some View {
        TabView {
            NewsListView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.News, systemImage: Constants.newspaper)
                }
            
            BookmarksView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Bookmarks, systemImage: Constants.bookmark)
                }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
