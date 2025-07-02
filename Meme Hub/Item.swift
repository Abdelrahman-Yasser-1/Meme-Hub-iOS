//
//  Item.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 02/07/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
