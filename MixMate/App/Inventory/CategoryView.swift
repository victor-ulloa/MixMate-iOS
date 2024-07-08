//
//  CategoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showingAddItem = false
    
    let inventoryItems: [InventoryItem]?
    let category: InventoryItemType
    
    var body: some View {
        List {
            if let items = inventoryItems, !items.isEmpty {
                ForEach(items, id: \.self) { item in
                    Text(item.name)
                }
            }
        }
        .navigationTitle(category.getLabel())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddItem.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddItem, onDismiss: didDismiss, content: {
                    AddItemView(isPresented: $showingAddItem, category: category)
                })
            }
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

#Preview {
    NavigationStack {
        CategoryView(inventoryItems: nil, category: .spirit)
    }
}
