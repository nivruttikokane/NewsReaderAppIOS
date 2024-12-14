//
//  ArticleDetailView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI


struct ArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let img = article.urlToImage {
                    AsyncImage(url: URL(string:img)) { phase in
                        switch phase {
                        case .empty:
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            HStack {
                                Spacer()
                                Image(systemName: "photo")
                                    .imageScale(.large)
                                Spacer()
                            }
                        @unknown default:
                            fatalError()
                        }
                    }
                    .frame(minHeight: 200, maxHeight: 300)
                    .background(Color.gray.opacity(0.3))
                    .clipped()
                }
                Text(article.title)
                    .font(.headline)
                    .lineLimit(10)
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(30)
                }
                
                if let publishedAt = article.publishedAt {
                    let date = convertDDMMYYYFormat(dateString: publishedAt)
                    if let dateStr = date {
                        Text(dateStr)
                            .lineLimit(1)
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                }
                if let content = article.content {
                    Text(content)
                        .lineLimit(50)
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }.padding()
        }
        .navigationTitle("Article")
    }
}
extension ArticleDetailView {
    func convertDDMMYYYFormat(dateString : String)->String?{
        // Step 1: Convert the string to a Date object
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputFormatter.date(from: dateString) {
            
            // Step 2: Convert the Date object to the desired string format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"  // Desired format: DDMMYYYY
            let formattedDate = outputFormatter.string(from: date)
            print(formattedDate)  // Output: "11122024"
            return formattedDate
            
        } else {
            print("Invalid date format")
            return nil
        }
    }
}

