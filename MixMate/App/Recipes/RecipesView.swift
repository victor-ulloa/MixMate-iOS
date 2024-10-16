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
    
    var searchResults: [Cocktail] {
        if searchText.isEmpty {
            return viewModel.filteredCocktails
        } else {
            return viewModel.filteredCocktails.filter { $0.name?.contains(searchText) ?? false }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12){
                        ForEach(Tags.allCases, id: \.rawValue) { item in
                            TagToggle(type: item, selectedTags: $viewModel.selectedTags)
                        }
                    }
                    .padding(.leading, 20)
                }
                
                ScrollView(.vertical) {
                    VStack {
                        ForEach(searchResults, id: \.id){ cocktail in
                            NavigationLink {
                                if let _ = cocktail.recipe {
                                    RecipeDetailView(cocktail: cocktail)
                                }
                            } label: {
                                RecipeListItem(cocktail: cocktail)
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.top, 12)
                }
            }
            .navigationTitle("Recipes")
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    RecipesView()
}
