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
    let ingredients: String
    let calories: Double?
    let alcoholContent: Double
    let complexity: Complexity
    let tags: [Tags]
    
    var decodedIngredientsData: [Ingredient]? {
        let data = Data(ingredients.utf8)
        return try? JSONDecoder().decode([Ingredient].self, from: data)
    }
    
}
