//
//  Ingredient.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-28.
//

import Foundation

struct Ingredient: Codable {
    
    let inventoryItem: InventoryItem
    let amount: Double
    let unit: String
    
}
