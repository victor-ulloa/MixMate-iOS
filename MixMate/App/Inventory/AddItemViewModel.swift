//
//  AddItemViewModel.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-07.
//

import Foundation

final class AddItemViewModel: ObservableObject {

    @Published var items: [InventoryItem] = []
    
    func fetchItemsByCategory(category: InventoryItemType) async {
        if let fetchedItems = await Supabase.shared.fetchCategoryItems(type: category) {
            DispatchQueue.main.async { [weak self] in
                self?.items = fetchedItems
            }
        }
    }
}
