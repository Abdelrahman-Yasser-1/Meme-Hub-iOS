//
//  AddToFavoriteSheetView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 04/07/2025.
//

import SwiftUI
import SwiftData

struct AddToFavoriteSheetView: View {
    var meme: Meme
    @State var note: String = ""
    @State var rate: Int = 3
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            Color(.lightCream)
                .edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: 20) {
                Text(meme.name)
                    .bold()
                    .font(.title)
                    .foregroundColor(Color.blue)
                
                ImageWithPlaceholderView(imageURL: meme.url)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 2)
                            .opacity(0.2)
                    )
                
                Text("Note:")
                    .font(.headline)
                TextField("So funny...", text: $note)
                    .textFieldStyle(.roundedBorder)
                
                Text("Rate:")
                    .font(.headline)
                RatingView(rating: $rate)
                
                Spacer()
                
                Button(action: {
                    addMeme()
                    dismiss()
                }) {
                    HStack (spacing: 16) {
                        Image(systemName: "plus")
                        Text("Add")
                            .padding(.vertical, 9)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.all, 20)
        }
    }
    
    private func addMeme() {
        withAnimation {
            let newMeme = FavoriteMeme(meme_id: meme.id, name: meme.name, url: meme.url, width: meme.width, height: meme.height, box_count: meme.box_count, captions: meme.captions, note:note, rate: rate)
            modelContext.insert(newMeme)
        }
    }
    
}

#Preview {
    AddToFavoriteSheetView(meme: Meme(id: "1", name: "Meme 1", url: "https://i.imgflip.com/22bdq6.jpg", width: 200, height: 200, box_count: 4, captions: 8273))
}
