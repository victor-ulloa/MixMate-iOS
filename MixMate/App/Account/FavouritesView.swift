//
//  FavouritesView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-10-24.
//

import SwiftUI

struct FavouritesView: View {
    
    @ObservedObject var viewModel = FavouritesViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.favourites, id: \.self) { favourite in
                NavigationLink {
                    if let _ = favourite.recipe {
                        RecipeDetailView(cocktail: favourite)
                    }
                } label: {
                    RecipeListItem(cocktail: favourite)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                }
            }
        }
        .navigationTitle("Favourites")
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    FavouritesView(viewModel: FavouritesViewModel())
}
