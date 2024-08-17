//
//  UserProfileView.swift
//  MixMate
//
//  Created by Kanchan Kaur on 2024-08-12.
//

import SwiftUI

struct UserProfileView: View {
    let profile: Profile
    @EnvironmentObject private var authManager: AuthenticationManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                 
                    if let profileImageUrl = profile.profileImageUrl, !profileImageUrl.isEmpty {
                        AsyncImage(url: URL(string: profileImageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 120, height: 120)
                                
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                    )
                                    .shadow(radius: 10)
                                    .frame(width: 120, height: 120)
                                
                            case .failure:
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                    )
                                    .shadow(radius: 10)
                                    .frame(width: 120, height: 120)
                            @unknown default:
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                    )
                                    .shadow(radius: 10)
                                    .frame(width: 120, height: 120)
                            }
                        }
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                            .shadow(radius: 10)
                            .frame(width: 120, height: 120)
                            .padding(.top, 70)
                    }
                    
                   
                    VStack(alignment: .leading, spacing: 10) {
                        profileRow(title: "Username", value: profile.username)
                        if let nickname = profile.nickname {
                            profileRow(title: "Nickname", value: nickname)
                        }
                        if let dateOfBirth = profile.dateOfBirth {
                            profileRow(title: "Date of Birth", value: dateOfBirth.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                    .padding()
                    
                   
                    if let bio = profile.bio {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Bio")
                                .font(.headline)
                            
                            Text(bio)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        }
                        .padding([.horizontal, .bottom])
                        .padding(.top, 30)
                    }
                    
                    Button(action: signOut) {
                        Text("Sign Out")
                            .font(.title3)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                    }
                }
                .padding(.top, 50)
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func profileRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 150, alignment: .leading)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.regular)
                .lineLimit(1)
        }
        .padding(.vertical, 5)
    }
    
    private func signOut() {
        Task {
            do {
                try await authManager.signOutUser()
                
                dismiss()
            } catch {
              
                print("Sign out error: \(error.localizedDescription)")
            }
        }
    }
}




struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(profile: Profile(
            id: "1",
            username: "Kanchan",
            nickname: "Kaur",
            dateOfBirth: Date(),
            bio: "This is a bio. Passionate mixologist with a love for crafting unique cocktails.",
            profileImageUrl: ""
        ))
        .environmentObject(AuthenticationManager())
    }
}



