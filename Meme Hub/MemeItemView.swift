//
//  MemeItemView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct MemeItemView: View {
    var meme: Meme
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ImageWithPlaceholderView(imageURL: meme.url)
            
            Text("\(meme.name)")
                .lineLimit(1)
                .padding()
                .fontWeight(.bold)
                .font(.title3)
        }
        .cornerRadius(8)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 2)
                .opacity(0.2)
        )
    }
}

#Preview {
    MemeItemView(meme: Meme(id: "1", name: "Meme 1", url: "https://i.imgflip.com/22bdq6.jpg", width: 200, height: 200, box_count: 0, captions: 8273))
}
