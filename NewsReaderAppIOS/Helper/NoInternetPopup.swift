//
//  NoInternetPopup.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI

struct NoInternetPopup: View {
    var dismissAction: () -> Void
    var body: some View {
        VStack {
            Text(Constants.NoInternetConnection)
                .font(.title)
                .padding()
            Text(Constants.PleaseCheckconnection)
                .padding()
            Button(Constants.Dismiss) {
                dismissAction() // Call dismiss action to hide the popup
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7))
        .cornerRadius(12)
        .padding()
        .foregroundColor(.white)
    }
}
