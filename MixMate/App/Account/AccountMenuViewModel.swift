//
//  AccountMenuViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-07.
//

import Foundation

final class AccountMenuViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    
    init() {
        Task {
            do {
                let user = try await Supabase.shared.instance.auth.user()
                await updateData(name: user.userMetadata[Constants.name]?.queryValue ?? "", email: user.email ?? "")
            } catch {
                await updateData(name: "", email: "")
            }
        }
    }
    
    @MainActor
    func updateData(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
