//
//  ItemView.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct ItemView: View {
    @State var count: Int = 0
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            imageView
            contentView
            Spacer()
            
            Group {
                if count > 0 {
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
    }
}

// MARK: - Actions
private extension ItemView {
    func onMinusTap() {
        count -= 1
    }
    
    func onPlusTap() {
        count += 1
    }
    
    func addToCart() {
        count = 1
    }
}

// MARK: - Subviews
private extension ItemView {
    var imageView: some View {
        Image("")
            .frame(width: 58, height: 58)
            .background(Color.secondary.opacity(0.5))
    }
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Key Holder")
                .font(.system(size: 12, weight: .medium))
            
            Text("$10")
                .foregroundStyle(Color("B3B3B3"))
            
            Text("Attractive DesignMetallic materialFour key hooksReliable & DurablePremium Quality")
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
                    Text("\(count)")
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
    ItemView()
}
