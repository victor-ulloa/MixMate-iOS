//
//  AccountViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-07.
//

import Foundation

final class AccountViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var sinceDate: String = ""
    
    init() {
        
        Task {
            do {
                let user = try await Supabase.shared.instance.auth.user()
                name = user.userMetadata[Constants.name]?.queryValue ?? ""
                email = user.email ?? ""
                sinceDate = user.createdAt.formatted()
            }
            catch {
                name = ""
                email = ""
                sinceDate = ""
            }
        }
    }
}
