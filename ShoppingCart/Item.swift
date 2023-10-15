//
//  Item.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import Foundation
//import SwiftData

//@Model

struct Item: Decodable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var thumbnail: String
    var price: Int
    
    
    
    
//    init(timestamp: Date) {
//        self.timestamp = timestamp
//    }
}
