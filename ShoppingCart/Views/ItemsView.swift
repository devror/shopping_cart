//
//  ItemsView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemsView: View {
    private let items: [String] = (0..<10).map { ("Item_\($0)") }
    
    var body: some View {
        itemsListView
            .navigationTitle("Items")
    }
}

// MARK: - Subviews

private extension ItemsView {
    var itemsListView: some View {
        List(items, id: \.self) { item in
            ItemView()
                .listRowBackground(Color.white)
        }
        .listStyle(.plain)
        .buttonStyle(.plain)
        
        .padding(.vertical, 20)
    }
}

#Preview {
    NavigationStack {
        ItemsView()
    }
}
