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
    @State var categoryItems: [InventoryItem]?
    
    @Binding var inventoryData: InventoryData?
    var category: InventoryItemType
    
    var filteredItems: [InventoryItem] {
        let items = categoryItems ?? []
        if !searchText.isEmpty {
            return categoryItems?.filter { $0.name.localizedCaseInsensitiveContains(searchText) } ?? []
        }
        let names = inventoryData?.items?.map { $0.name } ?? []
        
        return items.filter { !names.contains($0.name) }.sorted(by: { $0.name < $1.name })
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List(filteredItems, id: \.id) { item in
                Button {
                    Task {
                        var newData = inventoryData ?? InventoryData(items: [])
                        newData.items?.append(InventoryItem(id: UUID(), name: item.name, type: item.type))
                        inventoryData = newData
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
    @State var inventoryData: InventoryData? = InventoryData(items: [])
    return AddItemView(isPresented: $showingAddItem, inventoryData: $inventoryData, category: .spirit)
}
