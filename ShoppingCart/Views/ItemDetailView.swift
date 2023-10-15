//
//  ItemDetailView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 24) {
                CloseButton() { dismiss() }
                imageView(viewSize: proxy.size.width)
                contentView
            }
        }
        .padding(24)
    }
}

// MARK: - Subviews

private extension ItemDetailView {
    func imageView(viewSize: CGFloat) -> some View {
        AsyncImageView(url: item.thumbnail, fill: true)
            .frame(width: viewSize, height: viewSize)
            .clipped()
    }
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(item.title)
                .font(.system(size: 30, weight: .semibold))
            
            Text("$\(item.price)")
                .font(.system(size: 30))
                .foregroundStyle(Color("B3B3B3"))
            
            Text(item.itemDescription)
                .font(.system(size: 20))
        }
    }
}

#Preview {
    ItemDetailView(item: .init(id: 1, title: "t", itemDescription: "d", thumbnail: "", images: [], price: 1, count: 0))
}
