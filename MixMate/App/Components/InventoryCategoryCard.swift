//
//  InventoryCategoryCard.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct InventoryCategoryCard: View {
    
    let imageName: String
    let label: String
    
    var body: some View {
        ZStack (alignment: .center) {
                Image(imageName)
                    .resizable()
                    .frame(height: 150)
                    .scaledToFit()
                    .overlay(content: {
                        Color.black.opacity(0.3)
                    })
                    .shadow(radius: 5)
                
                Text(label)
                    .font(.title)
                    .foregroundStyle(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)

    }
}

#Preview {
    InventoryCategoryCard(imageName: "spirit", label: "Spirits")
}
