//
//  RecipeDetailViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-28.
//

import Foundation

final class RecipeDetailViewModel: ObservableObject {
    
    let cocktail: Cocktail
    @Published var recipe: Recipe?
    @Published var isFavourite: Bool = false
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
        
        Task {
            if let recipeId = cocktail.recipe, let recipe = await Supabase.shared.fetchRecipe(id: recipeId) {
                DispatchQueue.main.async { [weak self] in
                    self?.recipe = recipe
                }
            }
        }
    }
    
}
