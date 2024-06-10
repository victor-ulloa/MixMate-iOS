//
//  RecipesCarouselItem.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct RecipesCarouselItem: View {
    
    var cocktail: Cocktail
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .frame(width: 150, height: 200)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    RecipesCarouselItem(cocktail: Cocktail(name: "Espresso Marini", shortDescription: "Discover the ultimate blend of rich espresso and smooth vodka!", imageName: "", imageURL: ""))
}
