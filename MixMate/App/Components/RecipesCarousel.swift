//
//  RecipesCarousel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct RecipesCarousel: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(0..<colors.count, id: \.self) { index in
                    RecipesCarouselItem(color: colors[index])
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RecipesCarousel()
}
