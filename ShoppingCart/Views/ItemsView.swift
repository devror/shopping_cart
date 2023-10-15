//
//  ItemsView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemsView: View {
    
    @StateObject private var viewModel = ItemsViewModel()
    
    @State private var isLoading = false
    @State private var isCartViewPresented = false
    @State private var isItemDetailViewPresented = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                if viewModel.items.isEmpty {
                    Text("No Items")
                } else {
                    itemsListView
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: { titleView })
            ToolbarItem(placement: .topBarTrailing, content: { cartButtonView })
        }
        .navigationDestination(isPresented: $isCartViewPresented, destination: {
            CartView()
        })
        .sheet(isPresented: $isItemDetailViewPresented, content: { itemDetailView })
        .task {
            isLoading = true
            await viewModel.load()
            isLoading = false
        }
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
        List(viewModel.items) { item in
            ItemView(item: item)
                .listRowBackground(Color.white)
                .onTapGesture {
                    viewModel.selectedItem = item
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
        .disabled(isLoading)
    }
    
    @ViewBuilder
    var itemDetailView: some View {
        if let selectedItem = viewModel.selectedItem {
            ItemDetailView(item: selectedItem)
        } else {
            Text("No selected item")
        }
    }
}

#Preview {
    NavigationStack {
        ItemsView()
    }
}
