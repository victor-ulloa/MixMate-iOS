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
            await fetchCocktails()
        }
    }
    
    func fetchCocktails() async {
        do {
            let fetchedCocktails: [Cocktail] = try await Supabase.shared.instance.from("cocktails").select().execute().value
            DispatchQueue.main.async { [weak self] in
                self?.cocktails = fetchedCocktails
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
