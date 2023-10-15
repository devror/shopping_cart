//
//  CloseButton.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Image(systemName: "xmark")
            .foregroundStyle(Color.black)
            .fontWeight(.semibold)
    }
}

#Preview {
    CloseButton() {}
}
