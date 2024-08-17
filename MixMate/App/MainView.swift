//
//  MainView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-08.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var isLoggedOut = false
    
    var body: some View {
        TabView(selection: $navigationManager.selectedTab) {
            HomepageView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tabs.home.rawValue)
            InventoryView()
                .environmentObject(authManager)
                .environmentObject(navigationManager)
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Inventory")
                }
                .tag(Tabs.inventory.rawValue)
            RecipesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
                .tag(Tabs.recipes.rawValue)
            AccountView()
                .environmentObject(authManager)
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
                .tag(Tabs.account.rawValue)
        }
    }
    
    
}


#Preview {
    MainView()
            .environmentObject(AuthenticationManager())
            .environmentObject(NavigationManager())
    
    
}
