//
//  InventoryItem.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import Foundation

struct InventoryItem: Codable {
    
    let id: UUID
    let name: String
    let type: InventoryItemType
    
}
