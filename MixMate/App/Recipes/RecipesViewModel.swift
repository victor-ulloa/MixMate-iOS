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
        
        $selectedTags
            .sink { [weak self] tagToggles in
                guard let self = self else { return }
                if tagToggles.isEmpty {
                    self.filteredCocktails = self.cocktails
                    return
                }
                
                filteredCocktails.removeAll()
                
                cocktails.forEach { cocktail in
                    var satisfies = true
                    
                    cocktail.tags.forEach { tagString in
                        if let tag = Tags(rawValue: tagString) {
                            if !self.selectedTags.contains(tag) {
                                satisfies = false
                            }
                        }
                    }
                    
                    if satisfies {
                        self.filteredCocktails.append(cocktail)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
