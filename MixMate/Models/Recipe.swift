//
//  Recipe.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-21.
//

import Foundation

struct Recipe: Codable {
 
    let id: UUID
    let description: String?
    let steps: [String]
    let ingredients: [Ingredient]?
    let calories: Double?
    let alcoholContent: Double
    let complexity: Complexity
    let tags: [Tags]
    
}
