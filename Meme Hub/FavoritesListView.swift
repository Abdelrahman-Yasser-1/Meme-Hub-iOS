//
//  FavoritesListView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI
import SwiftData

struct FavoritesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMemes: [FavoriteMeme]
    var body: some View {
        ZStack {
            Color(.lightCream)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(favoriteMemes.indices, id: \.self) { index in
                        let favoriteMeme = favoriteMemes[index]
                        FavoriteMemeItemView(favoriteMeme: favoriteMeme, memeIndex: index)
                    }
                }
                .padding()
                .navigationBarTitle("Favorites")
            }
        }
    }
}

#Preview {
    FavoritesListView()
}
