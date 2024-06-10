//
//  ImageCard.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct ImageCard: View {
    var body: some View {
        ZStack (alignment: .leading) {
            Image("frozenMargarita")
                .resizable()
                .frame(height: 200)
                .scaledToFit()
                .shadow(radius: 5)
            VStack (alignment: .leading) {
                Text("Frozen Margarita")
                    .font(.title)
                    .foregroundStyle(Color.white)
                
                Text("A perfect drink to enjoy the hot weather")
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
            }
            .padding(.horizontal, 20)
        }

    }
}

#Preview {
    ImageCard()
}
