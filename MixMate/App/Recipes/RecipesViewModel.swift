//
//  RecipesViewModel.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import Foundation

final class RecipesViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    
    init() {
        Task {
            if let cocktails = await Supabase.shared.fetchCocktails() {
                DispatchQueue.main.async { [weak self] in
                    self?.cocktails = cocktails
                }
            }
        }
    }
}
