//
//  SettingsView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-12-07.
//

import SwiftUI

struct SettingsView: View {
    
    @State var notificationsEnabled: Bool = true
    
    var body: some View {
        List {
            Section("Notifications") {
                Toggle("Enable notifications", isOn: $notificationsEnabled)
            }
            
            Button("Delete account") {
                
            }
            .foregroundStyle(.red)
        }
    }
}

#Preview {
    SettingsView()
}
