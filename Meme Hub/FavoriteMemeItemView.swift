//
//  MemeItemView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI
import SwiftData

struct FavoriteMemeItemView: View {
    var favoriteMeme: FavoriteMeme
    var memeIndex: Int
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMemes: [FavoriteMeme]

    @State private var rate: Int
    
    init(favoriteMeme: FavoriteMeme, memeIndex: Int) {
        self.favoriteMeme = favoriteMeme
        _rate = State(initialValue: favoriteMeme.rate)
        self.memeIndex = memeIndex
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageWithPlaceholderView(imageURL: favoriteMeme.url)
            
            Text("\(favoriteMeme.name)")
                .padding(.horizontal)
                .lineLimit(1)
                .fontWeight(.bold)
                .font(.title3)
            
            Text("\(favoriteMeme.note)")
                .padding(.horizontal)
                .font(.title3)
            
            RatingView(rating: $rate, viewOnly: true)
                .padding(.horizontal)
                .padding(.bottom, 8)

            Button(action: {
                deleteMeme(memeIndex:memeIndex)
            }) {
                HStack (spacing: 16) {
                    Image(systemName: "trash")
                    Text("Remove")
                        .padding(.vertical, 9)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .background(Color.red)
            .foregroundColor(Color.white)
            
        }
        .cornerRadius(8)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 2)
                .opacity(0.2)
        )
    }
    
    private func deleteMeme(memeIndex: Int) {
        withAnimation {
            modelContext.delete(favoriteMemes[memeIndex])
        }
    }
}

#Preview {
    FavoriteMemeItemView(favoriteMeme: FavoriteMeme(meme_id: "1", name: "Meme 1", url: "https://i.imgflip.com/22bdq6.jpg", width: 200, height: 200, box_count: 0, captions: 8273, note: "Meme Note...", rate: 3), memeIndex: 0)
}
