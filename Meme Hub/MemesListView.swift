//
//  ContentView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI
import SwiftData

enum LoadingState {
    case idle
    case loading
    case loaded
    case error(String)
}

struct MemesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMemes: [FavoriteMeme]
    
    let url = "https://api.imgflip.com/get_memes"
    
    @State var memes: [Meme] = []
    @State private var loadingState: LoadingState = .idle
    @State private var searchText = ""
    
    private var filteredMemes: [Meme] {
        if searchText.isEmpty {
            return memes
        }
        return memes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationSplitView {
            ZStack {
                Color(.lightCream)
                    .edgesIgnoringSafeArea(.all)
                
                switch loadingState {
                case .idle, .loading:
                    LoadingView()
                case .loaded:
                    if memes.isEmpty {
                        EmptyStateView(fetchMemes: fetchMemes)
                    } else {
                        MemesListContentView(fetchMemes: fetchMemes, filteredMemes: filteredMemes)
                    }
                case .error(let message):
                    ErrorStateView(message: message, fetchMemes: fetchMemes)
                }
            }
            .navigationTitle("Meme Hub")
            .searchable(text: $searchText, prompt: "Search memes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        FavoritesListView()
                    } label: {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                }
            }
        } detail: {
            Text("Select a meme")
                .font(.title2)
                .foregroundColor(.secondary)
        }
        .onAppear {
            fetchMemes()
        }
    }
        
    
    private func fetchMemes() {
        if memes.isEmpty {
            loadingState = .loading
        }
        
        guard let apiUrl = URL(string: url) else {
            loadingState = .error("Invalid URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // handle error state
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // handle no data state
                print("No data received.")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MemeResponse.self, from: data)
                memes = response.data.memes
                loadingState = .loaded
            } catch {
                print("Decoding failed: \(error)")
                loadingState = .error(error.localizedDescription)
            }
        }.resume()
    }
}



#Preview {
    MemesListView()
        .modelContainer(for: FavoriteMeme.self, inMemory: true)
}
