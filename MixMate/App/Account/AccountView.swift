//
//  AccountView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-17.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    
    @ObservedObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationStack {
            
            Group{
                switch (authManager.authState) {
                case .Initial:
                    Text("Loading")
                case .Signin:
                    Button {
                        Task {
                            await authManager.signOutUser()
                        }
                    } label: {
                        Text("Sign out")
                    }
                case .Signout:
                    SignUpView()
                        .environmentObject(authManager)
                }
            }
            .task {
                await authManager.isUserSignIn()
                
            }
        }
    }
}

#Preview {
    AccountView()
}
