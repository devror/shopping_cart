//
//  ItemDetailView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: ItemDetailViewModel
    
    init(itemID: Int) {
        _viewModel = StateObject(wrappedValue: ItemDetailViewModel(itemID: itemID))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                contentView
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

// MARK: - Subviews

private extension ItemDetailView {
    
    @ViewBuilder
    var contentView: some View {
        if let item = viewModel.item {
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: 24) {
                    CloseButton() { dismiss() }
                    imageView(item: item, viewSize: proxy.size.width)
                    contentView(item: item)
                }
            }
            .padding(24)
        } else {
            Text("No Data")
        }
    }
    
    func imageView(item: Item, viewSize: CGFloat) -> some View {
        AsyncImageView(url: item.thumbnail, fill: true)
            .frame(width: viewSize, height: viewSize)
            .clipped()
    }
    
    func contentView(item: Item) -> some View {
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
    ItemDetailView(itemID: 1)
}
