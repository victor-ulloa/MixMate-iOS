//
//  RecipeListItem.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-28.
//

import SwiftUI

struct RecipeListItem: View {
    
    let cocktail: Cocktail
    
    let imageSize: Double = 75
    
    var body: some View {
        ZStack(alignment: .center) {
            
            HStack(alignment: .center, spacing: 20) {
                if let imageURL = cocktail.imageURL, !imageURL.isEmpty {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .centreCropped()
                            .frame(width: imageSize, height: imageSize)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                            .padding(.vertical, 8)
                    } placeholder: {
                        Color.gray
                            .frame(width: imageSize, height: imageSize)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                            .padding(.vertical, 8)
                    }
                } else {
                    Color.gray
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                        .padding(.vertical, 8)
                }
                
                Text(cocktail.name ?? "")
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .gray, radius: 10, x: 8, y: 8)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RecipeListItem(cocktail: Cocktail(id: 1, name: "Frozen Margarita", shortDescription: "Indulge in a refreshing blend of zesty lime and tequila for a taste that's pure summer vibes!", imageURL: "", recipe: UUID(), tags: []))
}
