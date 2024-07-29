//
//  RecipeDetailView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-28.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    init(cocktail: Cocktail) {
        self.viewModel = RecipeDetailViewModel(cocktail: cocktail)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                if let imageURL = viewModel.cocktail.imageURL, !imageURL.isEmpty {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .black, radius: 10, x: 0, y: 10)
                    } placeholder: {
                        Color.gray
                            .frame(height: 300)
                            .shadow(color: .gray, radius: 10, x: 0, y: 10)
                    }
                }
                
                VStack(alignment: .center, spacing: 20) {
                    if let recipe = viewModel.recipe {
                        Text(recipe.description ?? "")
                        
                        VStack(alignment: .leading) {
                            Text("Steps")
                                .font(.title2)
                            ForEach(recipe.steps.indices, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text("\(index + 1).")
                                        .font(.headline)
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing, 8)
                                    
                                    Text(recipe.steps[index])
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .lineLimit(nil) // Allows for multiple lines of text
                                    Spacer()
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6)) // Light gray background for each step
                                .clipShape(RoundedRectangle(cornerRadius: 8)) // Rounded corners
                                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2) // Bottom shadow
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.cocktail.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(cocktail: Cocktail(id: 1, name: "Frozen Margarita", shortDescription: "Indulge in a refreshing blend of zesty lime and tequila for a taste that's pure summer vibes!", imageURL: "", recipe: UUID(uuidString: "a7716831-b07c-4117-bd3e-27548ba1e8eb"), tags: []))
    }
}
