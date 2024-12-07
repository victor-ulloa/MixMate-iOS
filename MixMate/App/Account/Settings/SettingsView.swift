//
//  SettingsView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-12-07.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    @State var notificationsEnabled: Bool = true
    
    var body: some View {
        List {
            Section("Notifications") {
                Toggle("Enable notifications", isOn: $notificationsEnabled)
            }
            
            Button("Delete account") {
                Task {
                    await authManager.deleteUserAccount()
                }
            }
            .foregroundStyle(.red)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthenticationManager())
}
