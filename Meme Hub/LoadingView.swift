//
//  LoadingView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading memes...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    LoadingView()
}
