//
//  CategoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showingAddItem = false
    
    let category: InventoryItemType
    
    var body: some View {
        List {
            Text("Vodka")
            Text("Rum")
            Text("Whiskey")
            Text("Gin")
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
                    AddItemView(isPresented: $showingAddItem)
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
        CategoryView(category: .spirit)
    }
}
