//
//  FavouritesViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-10-24.
//

import Foundation
import Combine

final class FavouritesViewModel: ObservableObject {
    
    @Published var favourites: [Cocktail] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadData() {
        Task {
            if let cocktails = await Supabase.shared.fetchCocktails(),
               let favourites = await Supabase.shared.getFavourites(),
               !favourites.isEmpty
            {
                DispatchQueue.main.async { [weak self] in
                    self?.favourites.removeAll()
                    favourites.forEach { id in
                        if let cocktail = cocktails.first(where: { $0.recipe == id }) {
                            self?.favourites.append(cocktail)
                        }
                    }
                }
            }
        }
    }
    
}

