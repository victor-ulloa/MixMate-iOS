//
//  RecipesView.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI
struct RecipesView: View {
    
    @StateObject var viewModel : RecipesViewModel = RecipesViewModel()
    @State var searchText = ""
    // var deciding whether show search bar or not.
    @State var showSearchBar = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - tags
                
                ScrollView(.horizontal) {
                    HStack(spacing: 12){
                        ForEach(Tags.allCases, id: \.rawValue) { item in
                            TagToggle(type: item, selectedTags: $viewModel.selectedTags)
                        }
                    }
                    .padding(.leading, 20)
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
            .navigationTitle("Recipes")
        }
        .searchable(text: $searchText)
    }
    
    private func filter(_ cocktail: Cocktail) -> Bool {
        var meetCriteria = true
        if searchText != "" && !(cocktail.name?.localizedCaseInsensitiveContains(searchText) ?? false) {
            meetCriteria = false
        }
        
        return meetCriteria
    }
    
    var searchResults: [Cocktail] {
        if searchText.isEmpty {
            return viewModel.cocktails
        } else {
            return viewModel.cocktails.filter { $0.name?.contains(searchText) ?? false }
        }
    }
}

#Preview {
    RecipesView()
}
