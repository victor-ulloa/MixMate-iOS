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
                    .shadow(radius: 5)
                
                Text(label)
                    .font(.title)
                    .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)

    }
}

#Preview {
    InventoryCategoryCard(imageName: "frozenMargarita", label: "Spirits")
}
