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
    var category: InventoryItemType
    let items = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grape", "Kiwi"]
    
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
                    
                    isPresented.toggle()
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
    return AddItemView(isPresented: $showingAddItem, category: .spirit)
}
