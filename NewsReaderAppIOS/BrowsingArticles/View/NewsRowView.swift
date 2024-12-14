//
//  NewsRowView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI
import Combine

struct NewsRowView: View {
    let article: Article
    @ObservedObject var viewModel: NewsViewModel
    @StateObject private var bluetoothViewModel = BluetoothViewModel(bluetoothService: BluetoothService())
    
    var body: some View {
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
                            Image(systemName: Constants.photo)
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
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(5)
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(5)
                }
                
                
                HStack(alignment: .center){
                    if let publishedAt = article.publishedAt {
                        let date = convertDDMMYYYFormat(dateString: publishedAt)
                        if let dateStr = date {
                            Text(dateStr)
                                .lineLimit(1)
                                .foregroundColor(.secondary)
                                .font(.caption)
                            
                        }
                        
                    }
                    
                    Spacer()
                    Button {
                        //viewModel.toggleBookmark(for: article)
                        viewModel.bookmarkArticle(article)
                    } label: {
                        Image(systemName: viewModel.isBookmarked(article) ? Constants.bookmarkfill : Constants.bookmark)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                       // if let url = article.url{
                            if let url = URL(string: article.url){
                                presentShareSheet(url: url)
                            }
                       // }
                    } label: {
                        Image(systemName: Constants.squareandarrowup)
                    }
                    .buttonStyle(.bordered)
                    
                    
                    Button {
                        bluetoothViewModel.startSharing(article: article)
                    } label: {
                        Image(systemName: Constants.waveforwardcirclefill)
                    }
                    .buttonStyle(.bordered)
                    if let receivedArticle = bluetoothViewModel.receivedArticle {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(Constants.ReceivedArticle)
                                .font(.headline)
                            Text(receivedArticle.title)
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                    
                }
            }
            .padding([.horizontal, .bottom])
            
            
        }
    }
}

extension NewsRowView {
    func convertDDMMYYYFormat(dateString : String)->String?{
        // Step 1: Convert the string to a Date object
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = Constants.yyyyMMddTHHmmssZ
        if let date = inputFormatter.date(from: dateString) {
            
            // Step 2: Convert the Date object to the desired string format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = Constants.ddMMyyyy  // Desired format: DDMMYYYY
            let formattedDate = outputFormatter.string(from: date)
            print(formattedDate)  // Output: "11122024"
            return formattedDate
            
        } else {
           // print("Invalid date format")
            return nil
        }
    }
}

extension View {
    
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
    
}
