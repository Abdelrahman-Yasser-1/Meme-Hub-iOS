//
//  ErrorStateView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct ErrorStateView: View {
    var message: String = ""
    var fetchMemes: () -> Void = { }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Oops! Something went wrong")
                .font(.headline)
            
            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Try Again") {
                fetchMemes()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorStateView()
}
