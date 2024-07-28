//
//  CategoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showingAddItem = false
    
    @ObservedObject var viewModel: InventoryViewModel
    let category: InventoryItemType
    
    var body: some View {
        List {
            if let items = viewModel.inventoryData?.items?.filter( { $0.type == category}).sorted(by: { $0.name < $1.name }), !items.isEmpty {
                ForEach(items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: deleteItems)
            }
        }
        .navigationTitle(category.getLabel())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddItem.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddItem) {
                    AddItemView(isPresented: $showingAddItem, inventoryData: $viewModel.inventoryData, category: category)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteItems(offsets: offsets, category: category)
        }
    }
}

#Preview {
    @State var inventoryData: InventoryData? = InventoryData(items: [
        InventoryItem(id: UUID(), name: "Vodka", type: .spirit),
        InventoryItem(id: UUID(), name: "Reposado", type: .spirit)
    ])
    @StateObject var viewModel: InventoryViewModel = InventoryViewModel()
    return NavigationStack { CategoryView(viewModel: viewModel, category: .spirit) }
}
