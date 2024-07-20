//
//  CategoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showingAddItem = false
    
    @Binding var inventoryData: InventoryData?
    let category: InventoryItemType
    
    var body: some View {
        List {
            if let items = inventoryData?.items?.filter( { $0.type == category}), !items.isEmpty {
                ForEach(items, id: \.name) { item in
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
                    AddItemView(isPresented: $showingAddItem, inventoryData: $inventoryData, category: category)
                })
            }
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

#Preview {
    @State var inventoryData: InventoryData? = InventoryData(items: [
        InventoryItem(name: "Vodka", type: .spirit),
        InventoryItem(name: "Reposado", type: .spirit)
    ])
    
    return NavigationStack { CategoryView(inventoryData: $inventoryData, category: .spirit) }
}
