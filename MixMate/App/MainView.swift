//
//  MainView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-08.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    
    var body: some View {
        TabView {
            HomepageView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            InventoryView()
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Inventory")
                }
            HomepageView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
            AccountView()
                .environmentObject(authManager)
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AuthenticationManager())
}
