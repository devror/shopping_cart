//
//  AsyncImageView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String?
    var fill = false
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            if let image = phase.image {
                if fill {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    image
                        .resizable()
                        .scaledToFit()
                }
            } else if phase.error != nil {
                Color.secondary.opacity(0.5)
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    AsyncImageView(url: "")
}
