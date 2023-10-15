//
//  ItemDetailViewModel.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-15.
//

import Foundation

enum ItemDetailViewModelError: LocalizedError {
    case cannotFetchItem
    
    var errorDescription: String? {
        "Something went wrong. Please try again"
    }
}

class ItemDetailViewModel: ObservableObject {
    
    @Published var item: Item?
    @Published var isLoading = false
    
    @Published var isAlertPresented = false
    @Published var error: ItemDetailViewModelError?
    
    let itemID: Int
    private let apiEndpointURL = "https://dummyjson.com/product"
    
    init(itemID: Int) {
        self.itemID = itemID
    }
    
    func load() async {
        guard let url = URL(string: "\(apiEndpointURL)/\(itemID)") else { return }
        
        await startLoading()
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                await presentError()
                return
            }
            
            let item = try JSONDecoder().decode(Item.self, from: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.item = item
                self?.stopLoading()
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            
            await presentError()
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
    private func presentError() {
        isAlertPresented = true
        error = .cannotFetchItem
        item = nil
    }
}
