//
//  ItemDetailView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 24) {
                CloseButton() { dismiss() }
                imageView(viewSize: proxy.size.width)
                contentView
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .padding(24)
    }
}

// MARK: - Subviews

private extension ItemDetailView {
    func imageView(viewSize: CGFloat) -> some View {
        Image("")
            .frame(width: viewSize, height: viewSize)
            .background(Color.secondary.opacity(0.5))
    }
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Item Name")
                .font(.system(size: 30, weight: .semibold))
            
            Text("$10")
                .font(.system(size: 30))
                .foregroundStyle(Color("B3B3B3"))
            
            Text("Attractive DesignMetallic materialFour key hooksReliable & DurablePremium Quality")
                .font(.system(size: 20))
        }
    }
}

#Preview {
    ItemDetailView()
}
