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
        ForEach(viewModel.favourites, id: \.self) { favourite in
            Text(favourite.name ?? "")
        }
    }
}

#Preview {
    FavouritesView(viewModel: FavouritesViewModel())
}
