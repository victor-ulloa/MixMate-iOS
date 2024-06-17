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
            Text(category.getLabel())
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddItem.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddItem, onDismiss: didDismiss, content: {
                    Text("ADD SCREEN")
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
