//
//  ItemDetailViewModel.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-15.
//

import Foundation

class ItemDetailViewModel: ObservableObject {
    
    @Published var item: Item?
    @Published var isLoading = false
    
}
