//
//  UserModel.swift
//  MixMate
//
//  Created by Kanchan Kaur on 2024-08-12.
//

import Foundation

struct Profile: Codable {
    var id: String
    var username: String
    var nickname: String?
    var dateOfBirth: Date?
    var bio: String?
    var profileImageUrl: String?
}
