//
//  InventoryView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct InventoryView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var navigationManager: NavigationManager
    
    @StateObject var viewModel: InventoryViewModel = InventoryViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(InventoryItemType.allCases, id: \.rawValue) { itemType in
                        NavigationLink {
                            CategoryView(inventoryItems: viewModel.inventory?.inventoryData?.items.filter( { $0.type == itemType}) ?? [], category: itemType)
                        } label: {
                            InventoryCategoryCard(imageName: itemType.getImageName(), label: itemType.getLabel())
                        }
                        
                    }
                }
                .listStyle(.plain)
                
                
                if viewModel.session == nil {
                    VStack(spacing: 20) {
                        Text("Log in to start saving your inventory!")
                            .font(.title)
                            .multilineTextAlignment(.center)
                        
                        Text("Having your inventory will allow you to get recipe recommendations according to what you have in hand!")
                            .font(.caption)
                            .padding(.horizontal)
                        Button {
                            navigationManager.selectedTab = Tabs.account.rawValue
                        } label: {
                            Text("Tap to log in!")
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
                }
            }
            .toolbar(viewModel.session == nil ? .hidden : .visible)
            .navigationTitle("Inventory")
        }
        .task {
            viewModel.session = await authManager.isUserSignIn()
        }
    }
}

#Preview {
    InventoryView()
}
