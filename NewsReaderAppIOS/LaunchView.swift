//
//  LaunchView.swift
//  NewsReaderAppIOS
//
//  Created by Nivrutti Kokane on 13/12/24.
//

import SwiftUI

struct LaunchView: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                ContentView() // The main screen of your app
            } else {
                // Your launch view content, like a logo or a simple image
                VStack {
                    Image(systemName: "windshield.front.and.fluid.and.spray") // Or use your logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                    Text("News Reader App")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .onAppear {
                    // Simulate loading time (can be adjusted)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}
