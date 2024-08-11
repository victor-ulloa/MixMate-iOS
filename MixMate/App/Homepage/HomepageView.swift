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
                        ImageCard(cocktail: cocktail)
                            .padding(.horizontal, 20)
                    }
                    RecipesCarousel(title: "Summer time!", cocktails: viewModel.summerCarousel)
                    RecipesCarousel(title: "But first coffee", cocktails: viewModel.coffeeCarousel)
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
        
    }
}

#Preview {
    HomepageView()
}
