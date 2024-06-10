//
//  RecipesCarouselItem.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct RecipesCarouselItem: View {
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(color)
            .frame(width: 150, height: 200)
            .shadow(radius: 5)
    }
}

#Preview {
    RecipesCarouselItem(color: .blue)
}
