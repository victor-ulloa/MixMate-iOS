//
//  RecipesViewModel.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import Foundation
import Combine

final class RecipesViewModel: ObservableObject {
    
    @Published var filteredCocktails: [Cocktail] = []
    @Published var selectedTags: [Tags] = []
    
    var cocktails: [Cocktail] = []
    var recipes: [Recipe] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            if let cocktails = await Supabase.shared.fetchCocktails() {
                DispatchQueue.main.async { [weak self] in
                    self?.cocktails = cocktails
                    self?.filteredCocktails = cocktails
                }
            }
        }
        
        Task {
            if let recipes = await Supabase.shared.fetchRecipes() {
                DispatchQueue.main.async { [weak self] in
                    self?.recipes = recipes
                }
            }
        }
        
        $selectedTags
            .sink { [weak self] selectedTags in
                guard let self = self else { return }
                if selectedTags.isEmpty {
                    self.filteredCocktails = self.cocktails
                    return
                }
                filteredCocktails.removeAll()
                
                self.recipes.forEach { recipe in
                    if Set(selectedTags).isSubset(of: Set(recipe.tags)) {
                        if let cocktail = self.cocktails.first(where: { $0.recipe == recipe.id }) {
                            self.filteredCocktails.append(cocktail)
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}
