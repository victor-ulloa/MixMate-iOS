//
//  AddItemView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct AddItemView: View {
    
    @Binding var isPresented: Bool
    @State var searchText: String = ""
    @State var categoryItems: [InventoryListItem]?
    
    var inventoryData: InventoryData
    var category: InventoryItemType
    
    var filteredItems: [InventoryListItem] {
        if searchText.isEmpty {
            return categoryItems ?? []
        } else {
            return categoryItems?.filter { $0.name.localizedCaseInsensitiveContains(searchText) } ?? []
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List(filteredItems, id: \.id) { item in
                Button {
                    Task {
                        var newData = inventoryData
                        newData.items?.append(InventoryItem(name: item.name, type: item.type))
                        let _ = await Supabase.shared.updateInventoryData(newInventoryData: newData)
                        isPresented.toggle()
                        
                    }
                } label: {
                    Text(item.name)
                }
            }
            .listStyle(.plain)
        }
        .task {
            if let categoryItems = await Supabase.shared.fetchCategoryItems(category: category) {
                DispatchQueue.main.async {
                    self.categoryItems = categoryItems
                }
            }
        }
    }
}

#Preview {
    @State var showingAddItem = false
    return AddItemView(isPresented: $showingAddItem, inventoryData: InventoryData(items: []), category: .spirit)
}
