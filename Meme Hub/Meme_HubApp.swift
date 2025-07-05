//
//  Meme_HubApp.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI
import SwiftData

@main
struct Meme_HubApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteMeme.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MemesListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
