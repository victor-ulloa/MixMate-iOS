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
    
}


// MARK: - Enums

enum InventoryItemType: String, Codable {
    case spirit
    case liqueur
    case mixer
    case juice
    case syrup
    case bitter
    case herbsAndSpices
    case others // eggs, milk, salt, suggar, coffee, tea, etc.
}
