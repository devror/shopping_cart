//
//  CartView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        itemsListView
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: { titleView })
                ToolbarItem(placement: .topBarTrailing, content: { closeButtonView })
            }
            .navigationBarBackButtonHidden()
    }
}

// MARK: - Subviews

private extension CartView {
    
    var titleView: some View {
        Text("Cart")
            .font(.system(size: 30, weight: .semibold))
            .padding(.leading, 18)
    }
    
    var itemsListView: some View {
        List(items, id: \.self) { item in
            ItemView(item: item)
                .listRowBackground(Color.white)
        }
        .listStyle(.plain)
        .buttonStyle(.plain)
        .safeAreaInset(edge: .bottom, content: {
            itemsTotalView
        })
        .padding(.vertical, 20)
    }
    
    var itemsTotalView: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Items")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                Text("2")
                    .font(.system(size: 16))
                    .foregroundStyle(Color("B3B3B3"))
            }
            
            HStack {
                Text("Total")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                Text("$10")
                    .font(.system(size: 16))
                    .foregroundStyle(Color("B3B3B3"))
            }
            
            HStack {
                Text("Grand Total")
                    .font(.system(size: 20, weight: .medium))
                
                Spacer()
                
                Text("$20")
                    .font(.system(size: 20))
                    .foregroundStyle(Color("B3B3B3"))
            }
            .padding(.top, 4)
        }
        .padding(24)
        .background(Color("FCFCFC"))
        .padding(.horizontal, 24)
    }
    
    var closeButtonView: some View {
        CloseButton() { dismiss() }
    }
}

#Preview {
    NavigationStack {
        CartView()
    }
}
