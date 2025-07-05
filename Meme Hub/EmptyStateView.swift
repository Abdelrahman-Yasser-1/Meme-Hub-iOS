//
//  EmptyStateView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct EmptyStateView: View {
    var fetchMemes: () -> Void = { }
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("No memes available")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Button("Try Again") {
                fetchMemes()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    EmptyStateView()
}
