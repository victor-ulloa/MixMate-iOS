//
//  Homepage.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-09.
//

import SwiftUI

struct HomepageView: View {
    
    @StateObject var viewModel = HomepageViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25){
                    if let cocktail = viewModel.cocktails.first {
                        NavigationLink {
                            RecipeDetailView(cocktail: cocktail, onUpdate: onCocktailUpdated)
                        } label: {
                            ImageCard(cocktail: cocktail)
                                .padding(.horizontal, 20)
                        }
                    }
                    RecipesCarousel(title: "Your Favourites!", cocktails: viewModel.favouritesCarousel, onUpdate: onCocktailUpdated)
                    RecipesCarousel(title: "Summer time!", cocktails: viewModel.summerCarousel, onUpdate: onCocktailUpdated)
                    RecipesCarousel(title: "But first coffee", cocktails: viewModel.coffeeCarousel, onUpdate: onCocktailUpdated)
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("MixMate")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("Welcome!")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
    
    func onCocktailUpdated() {
        Task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    HomepageView()
}
