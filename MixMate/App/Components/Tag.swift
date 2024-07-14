//
//  Tag.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI

struct Tag: View {
    
    let text: String
    @Binding var isOn: Bool
    
    var body: some View {
        
        Button(action: {
            isOn.toggle()
            print(text + " on: " + isOn.description)
        }){
            Text(text)
                .padding(5)
                .foregroundStyle(isOn ? Color.orange : Color.gray )
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(isOn ? Color.orange : Color.gray, lineWidth: 2))
        }
        
    }
}

#Preview {
    let text: String = "tag preview"
    @State var isOn = false
    return Tag(text: text, isOn: $isOn)
}
