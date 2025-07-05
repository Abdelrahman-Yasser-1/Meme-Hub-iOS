//
//  MemeDetails.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct MemeDetails: View {
    var meme: Meme
        
    var body: some View {
        ZStack {
            Color(.lightCream)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading, spacing: 12) {
                Text(meme.name)
                    .bold()
                    .font(.title2)
                
                ImageWithPlaceholderView(imageURL: meme.url)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 2)
                            .opacity(0.2)
                    )
                
                HStack {
                    Spacer()
                    Text("Width: \(meme.width)")
                    Spacer()
                    Text("Height: \(meme.height)")
                    Spacer()
                }
            }
            .safeAreaPadding(.all)
            .padding(.all)
        }
    }
}

#Preview {
    MemeDetails(meme: Meme(id: "1", name: "Meme 1", url: "https://i.imgflip.com/22bdq6.jpg", width: 200, height: 200, box_count: 0, captions: 8273))
}
