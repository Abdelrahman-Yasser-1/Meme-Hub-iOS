//
//  MemesListContentView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI
import SwiftData

struct MemesListContentView: View {
    var fetchMemes: () -> Void = { }
    var filteredMemes: [Meme]

    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMemes: [FavoriteMeme]
    
    @State var shouldPresentSheet = false

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredMemes) { meme in
                    NavigationLink {
                        MemeDetails(meme: meme)
                            .navigationBarTitle(meme.name, displayMode: .inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        shouldPresentSheet.toggle()
                                    }) {
                                        Label("Add to Favorites", systemImage: isFavorite(meme) ? "heart.fill" : "heart")
                                    }
                                    .sheet(isPresented: $shouldPresentSheet) {
                                        AddToFavoriteSheetView(meme: meme)
                                    }
                                }
                            }
                    } label: {
                        MemeItemView(meme: meme)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .scrollIndicators(.hidden)
        .refreshable {
            fetchMemes()
        }
    }
    
    private func isFavorite(_ meme: Meme) -> Bool {
        favoriteMemes.contains { $0.name == meme.name }
    }
}

#Preview {
//    MemesListContentView()
}
