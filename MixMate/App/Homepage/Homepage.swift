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
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25){
                    ImageCard(cocktail: cocktail)
                        .padding(.horizontal, 20)
                    RecipesCarousel(title: "Recomendations")
                    RecipesCarousel(title: "Recomendations")
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("MixMate")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("Welcome!")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        
    }
}

#Preview {
    Homepage()
}
