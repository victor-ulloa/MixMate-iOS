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
            Homepage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Homepage()
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Inventory")
                }
            Homepage()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
            Homepage()
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
