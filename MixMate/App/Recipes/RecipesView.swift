//
//  RecipesView.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI

struct TagToggle {
    var value: String
    var isOn: Bool
}


struct RecipesView: View {
    
    @StateObject var viewModel : RecipesViewModel = RecipesViewModel()
    @State var inputText = ""
    // var deciding whether show search bar or not.
    @State var showSearchBar = false
    
    @State var tagToggles: [TagToggle] = [
        TagToggle(value: Tags.nonalcoholic.getString(), isOn: false),
        TagToggle(value: Tags.dairyfree.getString(), isOn: false),
        TagToggle(value: Tags.cold.getString(), isOn: false),
        TagToggle(value: Tags.refreshing.getString(), isOn: false),
        TagToggle(value: Tags.bitter.getString(), isOn: false),
        TagToggle(value: Tags.sweet.getString(), isOn: false),
        TagToggle(value: Tags.sour.getString(), isOn: false),
        TagToggle(value: Tags.carbonated.getString(), isOn: false),
    ]
    
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
        NavigationStack {
            // search bar
            HStack {
                Spacer()
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
                    ForEach($tagToggles, id: \.value) {(tagToggle: Binding<TagToggle>) in
                        Tag(text: tagToggle.value.wrappedValue, isOn: tagToggle.isOn)
                    }
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
            }

            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    ForEach(viewModel.cocktails.filter({ cocktail in filter(cocktail)}), id: \.self){ cocktail in
                        ImageCard(cocktail: cocktail)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
    private func filter(_ cocktail: Cocktail) -> Bool {
        var meetCriteria = true
        if inputText != "" && !(cocktail.name?.localizedCaseInsensitiveContains(inputText) ?? false) {
            meetCriteria = false
        }
        for i in 0...tagToggles.count-1 {
            if tagToggles[i].isOn && cocktail.tags.firstIndex(of: tagToggles[i].value) == nil{
                meetCriteria = false
            }
        }
        return meetCriteria
    }
}

#Preview {
    RecipesView()
}
