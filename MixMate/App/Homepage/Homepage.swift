//
//  Homepage.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct Homepage: View {
    
    let cocktail = Cocktail(name: "Frozen Margarita", shortDescription: "Indulge in a refreshing blend of zesty lime and tequila for a taste that's pure summer vibes!", imageName: "frozenMargarita", imageURL: "")
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ImageCard(cocktail: cocktail)
                    .padding(.horizontal, 20)
                RecipesCarousel()
                    .padding(.leading, 20)
            }
            .padding(.top)
        }
        
    }
}

#Preview {
    Homepage()
}
