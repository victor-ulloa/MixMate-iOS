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
    let inventoryData: InventoryData?
    
    enum CodingKeys: String, CodingKey {
        case id, userId, inventoryData
    }
    
    init(id: UUID, userId: UUID, inventoryData: InventoryData?) {
        self.id = id
        self.userId = userId
        self.inventoryData = inventoryData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        userId = try container.decode(UUID.self, forKey: .userId)
        
        if let dataArray = try? container.decode([InventoryItem].self, forKey: .inventoryData) {
            inventoryData = InventoryData(items: dataArray)
        } else if let dataObject = try? container.decode(InventoryData.self, forKey: .inventoryData) {
            inventoryData = dataObject
        } else {
            inventoryData = nil
        }
    }
}

struct InventoryData: Codable {
    let items: [InventoryItem]
}
