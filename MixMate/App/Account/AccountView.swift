//
//  AccountView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-17.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationStack {
            
            Group{
                switch (authManager.authState) {
                case .Initial:
                    Text("Loading")
                case .Signin:
                    AccountMenuView()
                        .environmentObject(authManager)
                case .Signout:
                    SignUpView()
                        .environmentObject(authManager)
                }
            }
            .task {
                let _ = await authManager.isUserSignIn()
            }
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthenticationManager())
}
