//
//  MixMateApp.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-08.
//

import SwiftUI

@main
struct MixMateApp: App {
    
    @StateObject private var authManager = AuthenticationManager()
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authManager)
                .environmentObject(navigationManager)
        }
    }
}
