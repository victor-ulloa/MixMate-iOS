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
            AsyncImage(url: URL(string: cocktail.imageURL ?? "")) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray)
                        .frame(width: 150, height: 200)
                        .shadow(radius: 5)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        )
                        .shadow(radius: 5)
                case .failure:
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.red.opacity(0.3))
                        .frame(width: 150, height: 200)
                        .shadow(radius: 5)
                @unknown default:
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray)
                        .frame(width: 150, height: 200)
                        .shadow(radius: 5)
                }
            }
            
            VStack {
                Text(cocktail.name ?? "")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 130, alignment: .leading)
            }
            .padding(.bottom, 10)
            .padding(.leading, 10)
        }
        .padding(.leading, 20)
    }
}

#Preview {
    RecipesCarouselItem(cocktail: Cocktail(id: 1, name: "Espresso Martini", shortDescription: "Discover the ultimate blend of rich espresso and smooth vodka!", imageURL: "https://npcddrdidmrwljkyxolk.supabase.co/storage/v1/object/public/Images/cocktails/EspressoMartini.png", recipe: UUID()))
}
