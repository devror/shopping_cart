//
//  ItemsViewModel.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import Foundation

class ItemsViewModel: ObservableObject {
    
    @Published var items = [Item]()
    @Published var selectedItem: Item?
    
    @Published var isAlertPresented = false
    @Published var error: ItemsRepositoryError?
    
    private let itemsRepository = ItemsRepository()
        
    func load() async {
        do {
            let items = try await itemsRepository.fetchAll()
            
            DispatchQueue.main.async { [weak self] in
                self?.items = items
            }
        } catch {
            presentError(error as? ItemsRepositoryError)
        }
    }
    
    private func presentError(_ error: ItemsRepositoryError?) {
        DispatchQueue.main.async { [weak self] in
            self?.isAlertPresented = true
            self?.error = error
            self?.items = []
        }
    }
}
