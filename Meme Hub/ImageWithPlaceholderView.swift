//
//  ImageWithPlaceholderView.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

struct ImageWithPlaceholderView: View {
    
    var imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { response in
            switch response {
            case .success(let image):
                image.resizable()
                    .scaledToFit()
            case .failure(_):
                ImagePlaceholderView(withLoadingIndicator: false)
            default:
                ImagePlaceholderView(withLoadingIndicator: true)
            }
        }
    }
}

#Preview {
    Spacer()
    Text("Working Image")
    ImageWithPlaceholderView(imageURL: "https://i.imgflip.com/1ur9b0.jpg")
        .frame(width: 200, height: 200)
    Spacer()
    Text("Broken Image")
    ImageWithPlaceholderView(imageURL: "https://i.imgflip.com/1u")
        .frame(width: 200, height: 200)
    Spacer()
    
}
