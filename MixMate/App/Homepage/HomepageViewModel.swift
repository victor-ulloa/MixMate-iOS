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
            let response: [Cocktail] = try await Supabase.shared.instance.from("cocktails").select().execute().value
            print(response)
        } catch {
            print("Error: \(error)")
        }
        
        
    }
    
}
