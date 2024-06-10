//
//  Homepage.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        VStack {
            ImageCard()
                .padding(.horizontal, 20)
            RecipesCarousel()
                .padding(.leading, 20)
        }
        
    }
}

#Preview {
    Homepage()
}
