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
    let inventoryData: InventoryData

}

struct InventoryData: Codable {
    let items: [InventoryItem]
}
