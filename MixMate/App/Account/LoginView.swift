//
//  LoginView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authManager: AuthenticationManager
    @State private var navigateToUserProfile = false
    @State private var profile: Profile? = nil
    
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 40) {
                    Text("MixMate")
                        .font(.system(size: 45, weight: .bold))
                        .padding(.top, 25)
                    
                    VStack(spacing: 15) {
                        Text("Welcome back!")
                            .font(.title2)
                    }
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.leading)
                            TextField("email", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray.opacity(0.5))
                                }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Password")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.leading)
                            
                            PasswordField(fieldLabel: "password", password: $password)
                            
                            NavigationLink(
                                destination: ForgetPassword()
                                    .environmentObject(authManager),
                                label: {
                                    Text("Forget Password?")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 110)
                                }
                            )
                            .padding(.top, 10)
                        }
                    }
                    
                    Button {
                        Task {
                            if await authManager.logIn(email: email, password: password) {
                                if !authManager.isLoading {
                                    // Assuming a method to fetch profile after login
                                    profile = await fetchProfile() // Fetch or create Profile
                                    navigateToUserProfile = true
                                }
                            }
                        }
                    } label: {
                        if authManager.isLoading {
                            ProgressView()
                                .padding(.vertical, 15)
                        } else {
                            Text("Log in")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 15)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    NavigationLink(
                        destination: UserProfileView(profile: profile ?? Profile(id: "", username: "", nickname: nil, dateOfBirth: nil, bio: nil, profileImageUrl: nil)),
                        isActive: $navigateToUserProfile,
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
            }
            
        }
    }
    

    func fetchProfile() async -> Profile? {
        return Profile(id: "1", username: "User", nickname: "Nickname", dateOfBirth: Date(), bio: "Bio", profileImageUrl: "")
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationManager())
}
