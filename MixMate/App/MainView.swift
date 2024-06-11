//
//  MainView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-08.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomepageView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            HomepageView()
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Inventory")
                }
            HomepageView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
            HomepageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainView()
}
