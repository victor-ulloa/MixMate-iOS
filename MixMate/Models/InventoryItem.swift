//
//  InventoryItem.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import Foundation

struct InventoryItem: Codable, Hashable {
    
    let name: String
    let quantity: Double
    let type: InventoryItemType
    let unit: String
    
}
