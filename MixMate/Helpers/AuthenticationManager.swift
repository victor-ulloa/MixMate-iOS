//
//  AuthenticationManager.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-07.
//

import Foundation
import Combine


class AuthenticationManager: ObservableObject {
    
    // Published properties for SwiftUI views
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: Error?
    @Published var authState: AuthState = AuthState.Initial
    @Published var isLoading = false
    
    // Cancellable set to manage Combine subscriptions
    var cancellable = Set<AnyCancellable>()
    
    // Check if the user is signed in
    @MainActor
    func isUserSignIn() async {
        do {
            let _ = try await Supabase.shared.instance.auth.session
            authState = AuthState.Signin
        } catch _ {
            authState = AuthState.Signout
        }
    }
    
    // Sign up a new user
    @MainActor
    func signUp(email: String, password: String) async {
        do {
            isLoading = true
            try await Supabase.shared.instance.auth.signUp(email: email, password: password)
            authState = AuthState.Signin
            isLoading = false
        } catch let error {
            self.error = error
            isLoading = false
        }
    }
    
    // Sign in a user
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
    
    // Sign out a user
    @MainActor
    func signOutUser() async {
        do {
            try await Supabase.shared.instance.auth.signOut()
            authState = AuthState.Signout
        } catch let error {
            self.error = error
        }
    }
}
