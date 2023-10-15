//
//  Item.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import Foundation
import SwiftData

@Model
final class Item: Decodable, Identifiable {
    var id: Int
    var title: String
    var itemDescription: String
    var thumbnail: String
    var price: Int
    var count: Int = 0
    
    init(id: Int, title: String, itemDescription: String, thumbnail: String, price: Int, count: Int) {
        self.id = id
        self.title = title
        self.itemDescription = itemDescription
        self.thumbnail = thumbnail
        self.price = price
        self.count = count
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case itemDescription = "description"
        case thumbnail
        case price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.itemDescription = try container.decode(String.self, forKey: .itemDescription)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.price = try container.decode(Int.self, forKey: .price)
    }
}
