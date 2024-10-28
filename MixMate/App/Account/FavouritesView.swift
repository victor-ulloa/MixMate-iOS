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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FavouritesView(viewModel: FavouritesViewModel())
}
