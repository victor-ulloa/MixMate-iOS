//
//  CategoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showingAddItem = false
    
    let inventoryData: InventoryData?
    let category: InventoryItemType
    
    var body: some View {
        List {
            if let items = inventoryData?.items.filter( { $0.type == category}), !items.isEmpty {
                ForEach(items, id: \.type) { item in
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
                    AddItemView(isPresented: $showingAddItem, inventoryData: inventoryData ?? InventoryData(items: []), category: category)
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
        CategoryView(inventoryData: nil, category: .spirit)
    }
}
