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
    
    private let apiEndpointURL = "https://dummyjson.com/products"
    
    func load() async {
        guard let url = URL(string: apiEndpointURL) else { return }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            
            let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.items = productsResponse.products
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            
            DispatchQueue.main.async { [weak self] in
                self?.items = []
            }
        }
    }
}

// MARK: - DTO

private extension ItemsViewModel {
    struct ProductsResponse: Decodable {
        let products: [Item]
    }
}
