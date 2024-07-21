//
//  InventoryViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import Foundation
import Combine
import Auth

final class InventoryViewModel: ObservableObject {
    
    @Published var inventory: Inventory?
    @Published var inventoryData: InventoryData?
    @Published var session: Session?
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        $session
            .sink { [weak self] session in
                guard let self = self else { return }
                Task {
                    if let inventory = await Supabase.shared.fetchInventory() {
                        DispatchQueue.main.async {
                            self.inventory = inventory
                            self.inventoryData = inventory.decodedInventoryData
                        }
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    func deleteItems(offsets: IndexSet, category: InventoryItemType) {
        Task {
            guard var newData = inventoryData, var newCategoryItems = inventoryData?.items?.filter( { $0.type == category}).sorted(by: { $0.name < $1.name }) else { return }
            newCategoryItems.remove(atOffsets: offsets)
            newData.items?.removeAll(where: { $0.type == category })
            newData.items?.append(contentsOf: newCategoryItems)
            inventoryData = newData
            let _ = await Supabase.shared.updateInventoryData(newInventoryData: newData)
        }
    }
    
}
