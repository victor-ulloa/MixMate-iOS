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
                ZStack {
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
                    
                    Button {
                        viewModel.isFavourite.toggle()
                    } label: {
                        Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(.pink)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                }
                
                VStack(alignment: .center, spacing: 20) {
                    if let recipe = viewModel.recipe {
                        // MARK: Tags
                        Divider()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(recipe.tags, id: \.rawValue) { tag in
                                    Text(tag.getString().capitalized)
                                        .font(.callout)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(Color.accentColor.opacity(0.8))
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    
                                }
                            }
                        }
                        
                        // MARK: Description
                        Text(recipe.description ?? "")
                        
                        // MARK: Complexity
                        HStack {
                            Text("Complexity")
                            switch recipe.complexity {
                            case .easy:
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                                Image(systemName: "circle")
                                Image(systemName: "circle")
                            case .medium:
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.yellow)
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.yellow)
                                Image(systemName: "circle")
                            case .hard:
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.red)
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.red)
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.red)
                            }
                            Spacer()
                        }
                        
                        // MARK: Ingredients
                        // TODO: Match check or X if the user has the ingredient
                        Divider()
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Ingredients")
                                .font(.title3)
                            VStack(alignment: .leading, spacing: 10) {
                                if let ingredients = recipe.ingredients {
                                    ForEach(ingredients, id: \.inventoryItem.id) { ingredient in
                                        HStack {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                                .frame(width: 24, height: 24)
                                            
                                            Text(ingredient.inventoryItem.name)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                                .padding(.leading, 8)
                                            
                                            Spacer()
                                            
                                            Text("\(ingredient.amount, specifier: "%.1f")")
                                            Text(ingredient.unit)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .padding(.vertical)
                            .background(Color(UIColor.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        
                        // MARK: Steps
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Steps")
                                .font(.title3)
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
                        
                        // MARK: Information
                        Divider()
                        VStack(alignment: .leading) {
                            
                            Text("Information per serving")
                                .font(.title3)
                            
                            GroupBox() {
                                HStack {
                                    Text("Alcohol content")
                                    Spacer()
                                    Text("\(recipe.alcoholContent, specifier: "%.1f")% ABV")
                                }
                                .font(.footnote)
                                
                                HStack {
                                    Text("Calories")
                                    Spacer()
                                    Text("\(recipe.calories ?? 0, specifier: "%.f")")
                                }
                                .font(.footnote)
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.cocktail.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.setUpObservers()
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(cocktail: Cocktail(id: 1, name: "Frozen Margarita", shortDescription: "Indulge in a refreshing blend of zesty lime and tequila for a taste that's pure summer vibes!", imageURL: "https://npcddrdidmrwljkyxolk.supabase.co/storage/v1/object/public/Images/cocktails/pexels_kimvanvuuren_1590154.jpg", recipe: UUID(uuidString: "a7716831-b07c-4117-bd3e-27548ba1e8eb")))
    }
}
