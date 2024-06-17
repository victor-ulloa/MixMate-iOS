//
//  SearchBar.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
            TextField("Search", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
    }
}

#Preview {
    @State var value: String = ""
    return SearchBar(text: $value)
}
