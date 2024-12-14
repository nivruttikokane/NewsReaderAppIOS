//
//  LoaderView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            
            ProgressView(Constants.Loading)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.white)
                .padding()
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure it fills the parent view
        .contentShape(Rectangle()) // Enable interaction blocking
    }
}
