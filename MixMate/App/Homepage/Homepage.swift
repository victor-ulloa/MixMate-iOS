//
//  Homepage.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ImageCard(imageName: "frozenMargarita", title: "Frozen Margarita", headline: "A perfect drink to enjoy the hot weather")
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
