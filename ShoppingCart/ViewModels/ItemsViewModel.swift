//
//  ItemsViewModel.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import Foundation

enum ItemsViewModelError: LocalizedError {
    case cannotFetchItems
    
    var errorDescription: String? {
        "Something went wrong. Please try again"
    }
}

class ItemsViewModel: ObservableObject {
    
    @Published var items = [Item]()
    @Published var selectedItem: Item?
    
    @Published var isAlertPresented = false
    @Published var error: ItemsViewModelError?
    
    private let apiEndpointURL = "https://dummyjson.com/products"
    
    func load() async {
        guard let url = URL(string: apiEndpointURL) else { return }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                presentError()
                return
            }
            
            let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.items = productsResponse.products
            }
        } catch {
            presentError()
        }
    }
    
    private func presentError() {
        DispatchQueue.main.async { [weak self] in
            self?.isAlertPresented = true
            self?.error = .cannotFetchItems
            self?.items = []
        }
    }
}

// MARK: - DTO

private extension ItemsViewModel {
    struct ProductsResponse: Decodable {
        let products: [Item]
    }
}
