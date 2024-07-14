//
//  SearchTagBarView.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI

struct SearchTagBarView: View {
    
    // var deciding whether show search bar or not.
    @State var showSearchBar = false
  
    // from RecipesView
    @Binding var inputText: String
    
    @State var tag1: Bool = false
    @State var tag2: Bool = false
    @State var tag3: Bool = false
     
  
    // Search bar textfield
    var SearchBarView: some View {
        VStack {
            TextField("Search something...", text: $inputText)
                .padding(5)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                // Search bar
                if showSearchBar {
                    SearchBarView
                        .transition(.move(edge: .top))
                } else {
                    Text("Recipes")
                        .bold()
                }
                 
                Spacer()
              
                // Search button to show search bar
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSearchBar.toggle()
                            inputText = ""
                        }
                    }
            }
            .font(.system(size: 25))
            .frame(height: 50)
            
            // tags
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Tag(text:"tag1")
                    Tag(text:"tag2")
                    Tag(text:"tag3")
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
            }
        }
        .frame(width: UIScreen.main.bounds.width-30, height: 100)
    }
}

#Preview {
    @State var value: String = ""
    return SearchTagBarView(inputText: $value)
}
