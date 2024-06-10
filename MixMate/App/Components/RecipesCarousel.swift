//
//  RecipesCarousel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct RecipesCarousel: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    let cocktails: [Cocktail] = [
        Cocktail(name: "Espresso Marini", shortDescription: "Discover the ultimate blend of rich espresso and smooth vodka!", imageName: "", imageURL: ""),
        Cocktail(name: "Whiskey Sour", shortDescription: "Unlock the perfect balance of whiskey, fresh citrus, and a touch of sweetness", imageName: "", imageURL: "")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(cocktails) { cocktail in
                    RecipesCarouselItem(cocktail: cocktail)
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RecipesCarousel()
}
