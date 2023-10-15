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
    
    @Published var isAlertPresented = false
    @Published var error: ItemsRepositoryError?
    
    let itemID: Int
    private let itemsRepository = ItemsRepository()
    
    init(itemID: Int) {
        self.itemID = itemID
    }
    
    func load() async {
        await startLoading()
        
        do {
            let item = try await itemsRepository.fetch(id: itemID)
            
            DispatchQueue.main.async { [weak self] in
                self?.item = item
                self?.stopLoading()
            }
        } catch {
            await presentError(error as? ItemsRepositoryError)
            await stopLoading()
        }
    }
    
    @MainActor
    private func startLoading() {
        isLoading = true
    }
    
    @MainActor
    private func stopLoading() {
        isLoading = false
    }
    
    @MainActor
    private func presentError(_ error: ItemsRepositoryError?) {
        isAlertPresented = true
        self.error = error
        item = nil
    }
}
