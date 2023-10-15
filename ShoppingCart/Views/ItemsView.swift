//
//  ItemsView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI
import SwiftData

struct ItemsView: View {
    
    @StateObject private var viewModel = ItemsViewModel()
    @Query private var cartItems: [Item]
    
    @State private var isLoading = false
    @State private var isCartViewPresented = false
    @State private var isItemDetailViewPresented = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                itemsListView
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
        .alert(isPresented: $viewModel.isAlertPresented, error: viewModel.error, actions: {
            Button("Cancel", role: .cancel) {}
            Button("Retry") { loadData() }
        })
        .task {
            await loadData()
        }
    }
}

// MARK: - Actions

private extension ItemsView {
    func onCartTap() {
        isCartViewPresented = true
    }
    
    func loadData() {
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        isLoading = true
        await viewModel.load()
        isLoading = false
    }
}

// MARK: - Subviews

private extension ItemsView {
    
    @ViewBuilder
    var itemsListView: some View {
        if viewModel.items.isEmpty {
            Text("No Items")
        } else {
            List(viewModel.items) { item in
                let existedItem = cartItems.first(where: { $0.id == item.id })
                
                ItemView(item: existedItem ?? item)
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
