//
//  AccountMenuView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-10-15.
//

import SwiftUI

struct AccountMenuView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    
    let profileImageUrl: String? = "https://example.com/profile-image.jpg"
    let profileName = "Profile name"
    let email = "email@email.com"
    
    var body: some View {
        NavigationView {
            List {
                
                // Profile
                Section {
                    NavigationLink {
                        UserProfileView()
                            .environmentObject(authManager)
                    } label: {
                        HStack {
                            if let imageUrl = profileImageUrl, !imageUrl.isEmpty {
                                AsyncImage(url: URL(string: imageUrl)) { phase in
                                    if let image = phase.image {
                                        imageTile(image: image)
                                    } else if phase.error != nil {
                                        placeholderTile
                                    } else {
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            } else {
                                placeholderTile
                            }
                            
                            VStack(alignment: .leading) {
                                Text(profileName)
                                    .font(.headline)
                                Text(email)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.vertical, 8)
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
                
                // Sign Out
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
    
    
    // Tile for images (loaded image)
    func imageTile(image: Image) -> some View {
        image
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            .background(Color.white)  // Background color for tile effect
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)  // Drop shadow for depth
    }
    
    // Placeholder tile with drop shadow and subtle appearance
    var placeholderTile: some View {
        Image(systemName: "person.crop.square.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.gray.opacity(0.5))  // Muted color
            .background(Color.white)  // White background for tile effect
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)  // Drop shadow for depth
    }
}

#Preview {
    AccountMenuView()
        .environmentObject(AuthenticationManager())
}
