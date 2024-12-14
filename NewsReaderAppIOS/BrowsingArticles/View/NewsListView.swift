//
//  NewsListView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//
import SwiftUI


struct NewsListView: View {
    @StateObject private var viewModel: NewsViewModel
    @State private var selectedCategory: String = Constants.general // Default category
    let categories = [Constants.general, Constants.business, Constants.entertainment, Constants.health, Constants.science]
    
    init(viewModel: NewsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.isLoading {
                    VStack {
                        ProgressView(Constants.Loadingnews)
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                      }
                   }
                    // Segmented control for category selection
                    Picker(Constants.category, selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category.capitalized).tag(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Apply segmented style
                    .onChange(of: selectedCategory) {
                        // Fetch news whenever the selected category changes
                        viewModel.fetchNews(category: selectedCategory)
                    }
                    
                    .padding()
                    
                    List {
                        ForEach(viewModel.articles) { article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                NewsRowView(article: article, viewModel: viewModel)
                            }
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                    
                    .listStyle(.plain)
                    .navigationTitle(Constants.News)
                .onAppear {
                    viewModel.fetchNews(category: selectedCategory)
                }
                .alert(isPresented: $viewModel.showNoInternetAlert) {
                    Alert(
                        title: Text(Constants.NoInternetConnection),
                        message: Text(Constants.PleaseCheckconnection),
                        dismissButton: .default(Text(Constants.OK))
                    )
                }
                .alert(isPresented: .constant(viewModel.errorMessage != nil), content: {
                    Alert(
                        title: Text(Constants.Error),
                        message: Text(viewModel.errorMessage ?? Constants.UnknownError),
                        dismissButton: .default(Text(Constants.OK), action: {
                            viewModel.errorMessage = nil  // Clear the error after dismissing the alert
                        })
                    )
                })
            }
        }
    }
}
