//
//  ImagePlaceholderView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct ImagePlaceholderView: View {
    var withLoadingIndicator: Bool = false
    
    var body: some View {
        ZStack {
            Image(.placeholder)
                .resizable()
                .scaledToFill()
            if withLoadingIndicator {
                Group {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.blushPink, Color.lightCream]
                        ),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.3)
                    ProgressView()
                        .scaleEffect(2)
                }
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        Text("With Loading")
        ImagePlaceholderView(withLoadingIndicator: true)
        Spacer()
        Text("Without Loading")
        ImagePlaceholderView(withLoadingIndicator: false)
        Spacer()
    }
    .safeAreaPadding(.all)
}
