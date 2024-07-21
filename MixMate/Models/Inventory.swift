//
//  Inventory.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import Foundation

struct Inventory: Codable {
    
    let id: UUID
    let userId: UUID
    let inventoryData: String?
    
    var decodedInventoryData: InventoryData? {
        guard let inventoryData = inventoryData else { return nil }
        let data = Data(inventoryData.utf8)
        return try? JSONDecoder().decode(InventoryData.self, from: data)
    }
}

struct InventoryData: Codable {
    var items: [InventoryItem]?
}
