//
//  UserState.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import Foundation

final class UserState {
    
    static let shared = UserState()
    
    let instance: UserState
    var isUserLoggedIn: Bool = false
    
    init() {
        self.instance = UserState()
    }
}
