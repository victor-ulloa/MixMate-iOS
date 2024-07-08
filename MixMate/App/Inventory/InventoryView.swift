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
                            CategoryView(category: itemType)
                        } label: {
                            InventoryCategoryCard(imageName: itemType.getImageName(), label: itemType.getLabel())
                        }
                        
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Inventory")
                
                if viewModel.session == nil {
                    VStack {
                        Text("Signed out")
                        Button {
                            navigationManager.selectedTab = Tabs.account.rawValue
                        } label: {
                            Text("go to sign in")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
                }
            }
        }
        .task {
            viewModel.session = await authManager.isUserSignIn()
        }
    }
}

#Preview {
    InventoryView()
}
