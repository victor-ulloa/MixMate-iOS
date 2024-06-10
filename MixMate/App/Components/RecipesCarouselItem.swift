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
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .frame(width: 150, height: 200)
                .shadow(radius: 5)
            
            VStack {
                Text(cocktail.name)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .frame(width: 130, alignment: .leading)
            }
            .padding()
            .padding(.leading, 10)
            
        }
    }
}

#Preview {
    RecipesCarouselItem(cocktail: Cocktail(name: "Espresso Martini", shortDescription: "Discover the ultimate blend of rich espresso and smooth vodka!", imageName: "", imageURL: ""))
}
