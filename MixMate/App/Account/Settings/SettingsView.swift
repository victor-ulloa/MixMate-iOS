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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section("Notifications") {
                Toggle("Enable notifications", isOn: $notificationsEnabled)
            }
            
            Button("Delete account") {
                Task {
                    await authManager.deleteUserAccount()
                    presentationMode.wrappedValue.dismiss()
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
