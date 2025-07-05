//
//  Item.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteMeme {
    var meme_id: String
    var name: String
    var url: String
    var width: Int
    var height: Int
    var box_count: Int
    var captions: Int
    var note: String
    var rate: Int
    
    init(meme_id: String, name: String, url: String, width: Int, height: Int, box_count: Int, captions: Int, note: String = "", rate: Int = 0) {
        self.meme_id = meme_id
        self.name = name
        self.url = url
        self.width = width
        self.height = height
        self.box_count = box_count
        self.captions = captions
        self.note = note
        self.rate = rate
    }
}
