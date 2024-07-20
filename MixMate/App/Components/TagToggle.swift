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
            Text(type.getString())
                .padding(5)
                .foregroundStyle(selectedTags.contains(where: { $0 == type }) ? Color.orange : Color.gray )
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(selectedTags.contains(where: { $0 == type }) ? Color.orange : Color.gray, lineWidth: 2))
        }
        
    }
}
