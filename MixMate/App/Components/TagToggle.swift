//
//  TagToggle.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI

struct TagToggle: View {
    
    let type: Tags
    @Binding var selectedTags: [Tags]
    
    var body: some View {
        
        Button {
            if selectedTags.contains(where: { $0 == type }) {
                selectedTags.removeAll(where: { $0 == type })
            } else {
                selectedTags.append(type)
            }
        } label: {
            
            if selectedTags.contains(where: { $0 == type })  {
                Text(type.getString())
                    .font(.callout)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(Color.accentColor.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } else {
                Text(type.getString())
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.6))
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            }
        }
        
    }
}
