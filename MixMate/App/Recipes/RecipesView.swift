//
//  RecipesView.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-08.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject var viewModel : RecipesViewModel = RecipesViewModel()
    @State var inputText = ""
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false){
                SearchTagBarView(inputText: $inputText)
                
                ForEach(viewModel.cocktails, id: \.self) { cocktail in
                    ImageCard(cocktail: cocktail)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
}

#Preview {
    RecipesView()
}
