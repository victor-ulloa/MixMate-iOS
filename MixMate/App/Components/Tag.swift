//
//  Tag.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI

struct Tag: View {
    
    let text: String
    @State var onOff: Bool = false
    
    var body: some View {
        
        if onOff {
            Text(text)
                .foregroundStyle(Color.orange)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.orange, lineWidth: 3))
                .onTapGesture {
                    onOff.toggle()
                }
        }
        else {
            Text(text)
                .foregroundStyle(Color.gray)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 3))
                .onTapGesture {
                    onOff.toggle()
                }
        }
    }
}

#Preview {
    let text: String = "tag preview"
    return Tag(text: text)
}
