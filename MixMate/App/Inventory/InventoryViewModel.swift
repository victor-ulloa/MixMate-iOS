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
    @Published var session: Session?
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        $session
            .sink { [weak self] session in
                guard let self = self else { return }
                Task {
                    if let userId = session?.user.id, let inventory = await Supabase.shared.fetchInventory(userId: userId) {
                        DispatchQueue.main.async {
                            self.inventory = inventory
                        }
                    }
                }
            }
            .store(in: &cancellable)
    }
    
}
