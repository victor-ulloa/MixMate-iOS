//
//  InventoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct InventoryView: View {
    
    @StateObject var viewModel: InventoryViewModel = InventoryViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(InventoryItemType.allCases, id: \.rawValue) { itemType in
                    NavigationLink {
                        CategoryView(category: itemType)
                    } label: {
                        InventoryCategoryCard(imageName: itemType.getImageName(), label: itemType.getLabel())
                    }
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Inventory")
        }
    }
}

#Preview {
    InventoryView()
}
