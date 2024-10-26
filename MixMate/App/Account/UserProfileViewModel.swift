//
//  UserProfileViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-07.
//

import Foundation

final class UserProfileViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var sinceDate: String = ""
    @Published var pfpData: Data?
    
    init() {
        Task {
            do {
                let user = try await Supabase.shared.instance.auth.user()
                await updateData(name: user.userMetadata[Constants.name]?.queryValue ?? "",
                           email: user.email ?? "",
                           sinceDate: user.createdAt.formatted(),
                           data: await Supabase.shared.downloadProfilePicture())
                
                
            } catch {
                await updateData(name: "", email: "", sinceDate: "", data: nil)
            }
        }
    }
    
    @MainActor
    func updateData(name: String, email: String, sinceDate: String, data: Data?) {
        self.name = name
        self.email = email
        self.sinceDate = sinceDate
        self.pfpData = data
    }
}
