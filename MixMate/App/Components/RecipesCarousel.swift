//
//  RecipesCarousel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct RecipesCarousel: View {
    
    let title: String
    let cocktails: [Cocktail] = [
        Cocktail(id: 1, name: "Espresso Marini", shortDescription: "Discover the ultimate blend of rich espresso and smooth vodka!", imageName: "", imageURL: "", tags: []),
        Cocktail(id: 2, name: "Whiskey Sour", shortDescription: "Unlock the perfect balance of whiskey, fresh citrus, and a touch of sweetness", imageName: "", imageURL: "", tags: [])
    ]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.title2)
                .padding(.leading, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(cocktails, id: \.self) { cocktail in
                        RecipesCarouselItem(cocktail: cocktail)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipesCarousel(title: "Recomendations")
}
