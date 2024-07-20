//
//  AddItemView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct AddItemView: View {
    
    @StateObject var viewModel = AddItemViewModel()
    
    @Binding var isPresented: Bool
    var selectedCategory: InventoryItemType
    @State var searchText: String = ""
    //let items = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grape", "Kiwi"]
    @State var items: [String] = []
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            if (filteredItems.isEmpty) {
                Text("no items to display")
            }
            List(filteredItems, id: \.self) { item in
                Button {
                    isPresented.toggle()
                } label: {
                    Text(item)
                }
            }.task {
                do {
                    try await viewModel.fetchItemsByCategory(category: selectedCategory)
                    viewModel.items.forEach{ item in
                        items.append(item.name)
                    }
                }catch {
                    items.append("failed to load")
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    @State var showingAddItem = false
    return AddItemView(isPresented: $showingAddItem, selectedCategory: .spirit)
}
