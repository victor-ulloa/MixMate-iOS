//
//  HomepageViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-10.
//

import Foundation
import Combine

final class HomepageViewModel: ObservableObject {
    
    @Published var cocktails: [Cocktail] = []
    @Published var recipes: [Recipe] = []
    @Published var summerCarousel: [Cocktail] = []
    @Published var coffeeCarousel: [Cocktail] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            if let cocktails = await Supabase.shared.fetchCocktails() {
                DispatchQueue.main.async { [weak self] in
                    self?.cocktails = cocktails
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
        
        Publishers.CombineLatest($cocktails, $recipes)
            .compactMap { ($0.0, $0.1) }
            .sink { [weak self] cocktails, recipes in
                let summerIDs = recipes.filter{ $0.tags.contains(.summer)}.compactMap { $0.id }
                let coffeeIDs = recipes.filter{ $0.tags.contains(.coffee)}.compactMap { $0.id }
                self?.coffeeCarousel = cocktails.filter{ obj in
                    if let recipeID = obj.recipe {
                        return coffeeIDs.contains(recipeID)
                    }
                    return false
                }
                self?.summerCarousel = cocktails.filter{ obj in
                    if let recipeID = obj.recipe {
                        return summerIDs.contains(recipeID)
                    }
                    return false
                }
            }
            .store(in: &cancellables)
    }
}
