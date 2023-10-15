//
//  ItemsRepository.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-15.
//

import Foundation

enum ItemsRepositoryError: LocalizedError {
    case invalidURL
    case badServerResponse
    
    var errorDescription: String? {
        "Something went wrong. Please try again"
    }
}

class ItemsRepository {
    
    private let baseURL = "https://dummyjson.com/products"
    private let urlSession = URLSession.shared
    
    func fetchAll() async throws -> [Item] {
        let productsResponse: ProductsResponse = try await fetchData(from: baseURL)
        return productsResponse.products
    }
    
    func fetch(id: Int) async throws -> Item {
        let url = "\(baseURL)/\(id)"
        let item: Item = try await fetchData(from: url)
        return item
    }
}

private extension ItemsRepository {
    func fetchData<T: Decodable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw ItemsRepositoryError.invalidURL
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ItemsRepositoryError.badServerResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - DTO

private extension ItemsRepository {
    struct ProductsResponse: Decodable {
        let products: [Item]
    }
}
