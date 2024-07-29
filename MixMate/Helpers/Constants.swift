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
    static let kInventoryListTable = "inventoryList"
    static let kInventoriesTable = "inventories"
    static let kInventoryTable = "inventoryList"
    static let kRecipesTable = "recipes"
    
}

// MARK: - Enums

enum Tags: String, Codable, CaseIterable {
    case nonAlcoholic
    case sweet
    case sour
    case bitter
    case cold
    case refreshing
    case carbonated
    case dairyFree
    case fruits
    case spices
    case summer
    case coffee
    case classic
    case elegant
    case smooth
    case sophisticated
    case spicy
    case herbal
    case juicy
    case vegan
    case tropical
    case frozen
    
    func getString () -> String {
        switch self {
        case .nonAlcoholic:
            return "non-alcoholic"
        case .dairyFree:
            return "dairy-free"
        default:
            return self.rawValue
        }
    }
}

enum InventoryItemType: String, Codable, CaseIterable {
    case spirit
    case liqueur
    case mixer
    case juice
    case syrup
    case bitters
    case herbsAndSpices
    case beer
    case wine
    case others // eggs, milk, salt, suggar, coffee, tea, etc.
    
    func getImageName() -> String {
        switch self {
        case .spirit:
            return "spirit"
        case .liqueur:
            return "liqueur"
        case .mixer:
            return "frozenMargarita"
        case .juice:
            return "juice"
        case .syrup:
            return "syrup"
        case .bitters:
            return "bitters"
        case .herbsAndSpices:
            return "herbsAndSpices"
        case .others:
            return "frozenMargarita"
        case .beer:
            return "frozenMargarita"
        case .wine:
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
        case .beer:
            return "Beer"
        case .wine:
            return "Wine"
        case .others:
            return "Others"
        }
    }
}

enum Tabs: Int {
    case home = 0
    case inventory = 1
    case recipes = 2
    case account = 3
}

enum Complexity: Int, Codable {
    case easy = 1
    case medium = 2
    case hard = 3
}

// MARK: - Authentication State

enum AuthState: Hashable {
    case Initial
    case Signin
    case Signout
}


