//
//  AuthenticationManager.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-07.
//

import Foundation
import Combine
import Auth


class AuthenticationManager: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: Error?
    @Published var authState: AuthState = AuthState.Initial
    @Published var isLoading = false
    
    @MainActor
    func isUserSignIn() async -> Session? {
        do {
            let session = try await Supabase.shared.instance.auth.session
            authState = AuthState.Signin
            return session
        } catch {
            authState = AuthState.Signout
            return nil
        }
    }
    
    @MainActor
    func signUp(email: String, password: String) async {
        do {
            isLoading = true
            let response = try await Supabase.shared.instance.auth.signUp(email: email, password: password)
            let newInventory = Inventory(id: UUID(), userId: response.user.id, inventoryData: nil)
            try await Supabase.shared.instance.from(Constants.kInventoriesTable).insert(newInventory).execute()
            authState = AuthState.Signin
            isLoading = false
        } catch let error {
            self.error = error
            isLoading = false
        }
    }
    
    @MainActor
    func logIn(email: String, password: String) async -> Bool {
        do {
            isLoading = true
            try await Supabase.shared.instance.auth.signIn(email: email, password: password)
            authState = AuthState.Signin
            isLoading = false
            return true
        } catch let error {
            self.error = error
            isLoading = false
            return false
        }
    }
    
    @MainActor
    func signOutUser() async {
        do {
            try await Supabase.shared.instance.auth.signOut()
            authState = AuthState.Signout
        } catch let error {
            self.error = error
        }
    }
    
    func login(email: String, password: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Fetch the user profile from your server or database
            let fetchedProfile = try await fetchUserProfile(email: email) // Use `try` here
            
            // If login successful and profile fetched
            if let profile = fetchedProfile {
                let user = try User(from: profile as! Decoder) // Assuming `User` can be initialized with `Profile`
                // Use the `user` object as needed
                return true
            } else {
                return false
            }
        } catch {
            // Handle any errors that might occur during fetching
            print("Error fetching user profile: \(error)")
            return false
        }
    }
        
        func fetchUserProfile(email: String) async -> Profile? {
            // Fetch the user profile logic
            // Return a Profile object based on the email
            return Profile(id: "1", username: "User", nickname: "Nickname", dateOfBirth: Date(), bio: "Bio", profileImageUrl: "")
        }
    }

