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
}
