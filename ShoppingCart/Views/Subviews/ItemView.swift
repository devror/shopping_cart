//
//  ItemView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var isAlertPresented = false
    
    let item: Item
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            imageView
            contentView
            Spacer()
            
            Group {
                if item.count > 0 {
                    countView
                        .transition(.asymmetric(insertion: .scale.animation(.easeInOut), removal: .opacity.animation(.easeInOut)))
                } else {
                    addToCartView
                        .transition(.asymmetric(insertion: .scale.animation(.easeInOut), removal: .opacity.animation(.easeInOut)))
                }
            }
        }
        .listRowSeparator(.hidden)
        .padding(16)
        .background(Color("FCFCFC"))
        .listRowInsets(.init(top: 4, leading: 24, bottom: 4, trailing: 24))
        .alert("Error", isPresented: $isAlertPresented) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Something went wrong. Please try again later.")
        }
    }
}

// MARK: - Actions
private extension ItemView {
    func onMinusTap() {
        item.count -= 1
        
        if item.count == 0 {
            withAnimation {
                modelContext.delete(item)
            }
        } else {
            save()
        }
    }
    
    func onPlusTap() {
        item.count += 1
        save()
    }
    
    func addToCart() {
        item.count = 1
        modelContext.insert(item)
        save()
    }
    
    func save() {
        do {
            try modelContext.save()
        } catch {
            isAlertPresented = true
        }
    }
}

// MARK: - Subviews
private extension ItemView {
    var imageView: some View {
        AsyncImageView(url: item.thumbnail)
            .frame(width: 58, height: 58)
            .clipped()
    }
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.system(size: 12, weight: .medium))
            
            Text("$\(item.price)")
                .foregroundStyle(Color("B3B3B3"))
            
            Text(item.itemDescription)
        }
        .font(.system(size: 12))
        .padding(.vertical, 4)
    }
    
    var addToCartView: some View {
        Button("Add to Cart", action: addToCart)
            .buttonStyle(.borderedProminent)
            .font(.system(size: 12, weight: .medium))
    }
    
    var countView: some View {
        HStack(spacing: 16) {
            Button(action: onMinusTap) {
                Image(systemName: "minus")
                    .frame(width: 30, height: 30)
            }
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("F5F6F6"))
                .frame(width: 30, height: 30)
                .overlay {
                    Text("\(item.count)")
                        .fontWeight(.semibold)
                }
            
            Button(action: onPlusTap) {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
            }
        }
        .buttonStyle(.borderless)
        .font(.system(size: 12))
        .foregroundColor(.black)
    }
}

#Preview {
    ItemView(item: .init(id: 1, title: "Title", itemDescription: "Description", thumbnail: "", images: [], price: 100, count: 0))
}
