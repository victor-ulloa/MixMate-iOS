//
//  AccountMenuView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-10-15.
//

import SwiftUI

struct AccountMenuView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            List {
                
                // Profile
                Section {
                    NavigationLink {
                        
                    } label: {
                        Text("Profile")
                    }
                }
                
                // Content
                Section {
                    NavigationLink {
                        
                    } label: {
                        Text("Favourites")
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        Text("Settings")
                    }
                }
                
                // Sign Out (No chevron and not tapable for navigation)
                Section {
                    Button {
                        Task {
                            await authManager.signOutUser()
                        }
                    } label: {
                        Text("Sign out")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountMenuView()
        .environmentObject(AuthenticationManager())
}
