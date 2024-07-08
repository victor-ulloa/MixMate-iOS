//
//  Constants.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-11.
//

import Foundation

struct Constants {
    
    //    MARK: - Supabase Table keys
    static let kCocktailsTable = "cocktails"
    static let kInventoryTable = "Inventory"
    
}


// MARK: - Enums

enum InventoryItemType: String, Codable, CaseIterable {
    case spirit
    case liqueur
    case mixer
    case juice
    case syrup
    case bitters
    case herbsAndSpices
    case others // eggs, milk, salt, suggar, coffee, tea, etc.
    
    func getImageName() -> String {
        switch self {
        case .spirit:
            return "frozenMargarita"
        case .liqueur:
            return "frozenMargarita"
        case .mixer:
            return "frozenMargarita"
        case .juice:
            return "frozenMargarita"
        case .syrup:
            return "frozenMargarita"
        case .bitters:
            return "frozenMargarita"
        case .herbsAndSpices:
            return "frozenMargarita"
        case .others:
            return "frozenMargarita"
        }
    }
    
    func getLabel() -> String {
        switch self {
        case .spirit:
            return "Spirits"
        case .liqueur:
            return "Liqueurs"
        case .mixer:
            return "Mixers"
        case .juice:
            return "Juices"
        case .syrup:
            return "Syrups"
        case .bitters:
            return "Bitters"
        case .herbsAndSpices:
            return "Herbs and Spices"
        case .others:
            return "Others"
        }
    }
}

// MARK: - Authentication State

enum AuthState: Hashable {
    case Initial
    case Signin
    case Signout
}


