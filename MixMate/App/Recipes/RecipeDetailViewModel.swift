//
//  RecipeDetailViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-28.
//

import Foundation
import Combine

final class RecipeDetailViewModel: ObservableObject {
    
    let cocktail: Cocktail
    @Published var recipe: Recipe?
    @Published var isFavourite: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
        Task {
            if let recipeId = cocktail.recipe, let recipe = await Supabase.shared.fetchRecipe(id: recipeId) {
                DispatchQueue.main.async { [weak self] in
                    self?.recipe = recipe
                }
                isFavourite = await Supabase.shared.getFavourites()?.contains(where: { $0 == recipeId }) ?? false
            }
        }
    }
    
    func setUpObservers() {
        $isFavourite
            .dropFirst()
            .sink { [weak self] isFavourite in
                guard let self = self, let recipeID = self.recipe?.id else { return }
                print(isFavourite)
                Task {
                    await Supabase.shared.updateFavourites(recipeID: recipeID)
                }
            }
            .store(in: &cancellables)
    }
    
}
