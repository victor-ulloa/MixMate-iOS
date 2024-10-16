//
//  RecipesCarousel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct RecipesCarousel: View {
    
    let title: String
    let cocktails: [Cocktail]
    
    var body: some View {
        if !cocktails.isEmpty {
            VStack (alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .padding(.leading, 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(cocktails, id: \.self) { cocktail in
                            NavigationLink {
                                RecipeDetailView(cocktail: cocktail)
                            } label: {
                                RecipesCarouselItem(cocktail: cocktail)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecipesCarousel(title: "Recomendations", cocktails: [
        Cocktail(id: 1, name: "Espresso Marini", shortDescription: "Discover the ultimate blend of rich espresso and smooth vodka!", imageURL: "", recipe: UUID()),
        Cocktail(id: 2, name: "Whiskey Sour", shortDescription: "Unlock the perfect balance of whiskey, fresh citrus, and a touch of sweetness", imageURL: "", recipe: UUID())
    ])
}
