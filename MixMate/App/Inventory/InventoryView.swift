//
//  InventoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct InventoryView: View {
    
    @StateObject var viewModel: InventoryViewModel = InventoryViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                List {
                    List {
                        Text("Hello World")
                        Text("Hello World")
                        Text("Hello World")
                    }
                }
            }
            .navigationTitle("Inventory")
        }
    }
}

#Preview {
    InventoryView()
}
