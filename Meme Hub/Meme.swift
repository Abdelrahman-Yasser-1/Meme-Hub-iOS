//
//  Meme.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import Foundation

struct MemeResponse: Codable {
    let success: Bool
    let data: MemeData
}

struct MemeData: Codable {
    let memes: [Meme]
}

struct Meme: Identifiable, Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let box_count: Int
    let captions: Int
}
