//
//  ImageCard.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct ImageCard: View {
    
    var imageName: String
    var title: String
    var headline: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            Image(imageName)
                .resizable()
                .frame(height: 200)
                .scaledToFit()
                .shadow(radius: 5)
            VStack (alignment: .leading) {
                Text(title)
                    .font(.title)
                    .foregroundStyle(Color.white)
                
                Text(headline)
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
            }
            .padding(.horizontal, 20)
        }

    }
}

#Preview {
    ImageCard(imageName: "frozenMargarita", title: "Frozen Margarita", headline: "A perfect drink to enjoy the hot weather")
}
