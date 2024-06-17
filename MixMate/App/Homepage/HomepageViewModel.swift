//
//  HomepageViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-10.
//

import Foundation

final class HomepageViewModel: ObservableObject {
    
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
