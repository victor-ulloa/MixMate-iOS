//
//  ImageCard.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct ImageCard: View {
    
    let cocktail: Cocktail
    
    var body: some View {
        ZStack (alignment: .center) {
            if let imageURL = cocktail.imageURL, !imageURL.isEmpty {
                AsyncImage(url: URL(string: cocktail.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .frame(height: 200)
                        .scaledToFit()
                        .shadow(radius: 5)
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 5)
                }
            } else {
                Image(cocktail.imageName ?? "")
                    .resizable()
                    .frame(height: 200)
                    .scaledToFit()
                    .shadow(radius: 5)
            }
            
                
            VStack (alignment: .leading) {
                Text(cocktail.name ?? "")
                    .font(.title)
                    .foregroundStyle(Color.white)
                
                Text(cocktail.shortDescription ?? "")
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)

    }
}

#Preview {
    ImageCard(cocktail: Cocktail(id: 1, name: "Frozen Margarita", shortDescription: "Indulge in a refreshing blend of zesty lime and tequila for a taste that's pure summer vibes!", imageName: "frozenMargarita", imageURL: ""))
}
