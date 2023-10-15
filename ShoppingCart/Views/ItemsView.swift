//
//  ItemsView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemsView: View {
    
    @State private var isCartViewPresented: Bool = false
    @State private var isItemDetailViewPresented: Bool = false
    
    private let items: [String] = (0..<10).map { ("Item_\($0)") }
    
    var body: some View {
        itemsListView
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: { titleView })
                ToolbarItem(placement: .topBarTrailing, content: { cartButtonView })
            }
            .navigationDestination(isPresented: $isCartViewPresented, destination: {
                CartView()
            })
            .sheet(isPresented: $isItemDetailViewPresented, content: {
                ItemDetailView()
            })
    }
}

// MARK: - Actions

private extension ItemsView {
    func onCartTap() {
        isCartViewPresented = true
    }
}

// MARK: - Subviews

private extension ItemsView {
    var itemsListView: some View {
        List(items, id: \.self) { item in
            ItemView()
                .listRowBackground(Color.white)
                .onTapGesture {
                    isItemDetailViewPresented = true
                }
        }
        .listStyle(.plain)
        .buttonStyle(.plain)
        
        .padding(.vertical, 20)
    }
    
    var titleView: some View {
        Text("Items")
            .font(.system(size: 30, weight: .semibold))
            .padding(.leading, 18)
    }
    
    var cartButtonView: some View {
        Button(action: onCartTap) {
            Image(systemName: "cart")
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    NavigationStack {
        ItemsView()
    }
}
