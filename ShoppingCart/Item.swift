//
//  Item.swift
//  ShoppingCart
//
//  Created by Taras Humeniuk on 2023-10-14.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
