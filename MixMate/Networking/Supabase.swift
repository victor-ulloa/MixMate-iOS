//
//  Supabase.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-10.
//

import Foundation
import Supabase

final class Supabase {
    
    static let shared = Supabase(urlString: "https://npcddrdidmrwljkyxolk.supabase.co", key: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wY2RkcmRpZG1yd2xqa3l4b2xrIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxODA2NTk2NCwiZXhwIjoyMDMzNjQxOTY0fQ.iHielmKxMmxEojHD7DjdScOLfbUWtLO2mZlcFi-S66Q")
    
    let instance: SupabaseClient
    
    init(urlString: String, key: String) {
        guard let url = URL(string: urlString) else {
            fatalError("Failed to initialize Supabase")
        }
        instance = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
    
    func getFavourites() async -> [UUID]? {
        do {
            if let metadata = instance.auth.currentUser?.userMetadata[Constants.MetaDataKeys.favourites.rawValue] {
                // Decode the array of UUID strings and map them to UUID objects
                let favouriteStrings = try metadata.decode(as: [String].self)
                return favouriteStrings.compactMap { UUID(uuidString: $0) }
            } else {
                return []
            }
        } catch {
            print("Error decoding favourites: \(error)")
            return nil
        }
    }
    
    func updateFavourites(recipeID: UUID) async {
        do {
            if var favourites = await getFavourites() {
                if favourites.contains(recipeID) {
                    favourites.removeAll(where: { $0 == recipeID })
                } else {
                    favourites.append(recipeID)
                }
                
                let jsonFavourites: [AnyJSON] = favourites.map { .string($0.uuidString) }
                
                try await instance.auth.update(
                    user: UserAttributes(
                        data: [
                            Constants.MetaDataKeys.favourites.rawValue: .array(jsonFavourites)
                        ]
                    )
                )
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func updateUserName(newName: String) async -> Bool {
        do {
            try await instance.auth.update(
              user: UserAttributes(
                data: [
                    Constants.name: .string(newName)
                ]
              )
            )
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func updateUserEmail(newEmail: String) async -> Bool {
        do {
            try await instance.auth.update(user: UserAttributes(email: newEmail))
            return true
        }catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func fetchCocktails() async -> [Cocktail]? {
        do {
            let fetchedCocktails: [Cocktail] = try await instance.from(Constants.kCocktailsTable).select().execute().value
            return fetchedCocktails
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func fetchInventory() async -> Inventory? {
        do {
            let session = try await Supabase.shared.instance.auth.session
            let response = try await instance
                .from(Constants.kInventoriesTable)
                .select()
                .execute()
            do {
                let inventories = try JSONDecoder().decode([Inventory].self, from: response.data)
                return inventories.first { $0.userId == session.user.id }
            } catch {
                print("Decoding error: \(error)")
                return nil
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func updateInventoryData(newInventoryData: InventoryData) async -> Bool {
        guard let jsonData = try? JSONEncoder().encode(newInventoryData),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to encode updated inventory")
            return false
        }
        
        // Update the inventory in Supabase
        do {
            let session = try await Supabase.shared.instance.auth.session
            _ = try await instance
                .from(Constants.kInventoriesTable)
                .update(["inventoryData": jsonString])
                .eq("userId", value: session.user.id)
                .execute()
            return true
        } catch {
            print("Error updating inventory: \(error)")
            return false
        }
    }
    
    func fetchCategoryItems(category: InventoryItemType) async -> [InventoryItem]? {
        do {
            let categoryItems: [InventoryItem] = try await instance.from(Constants.kInventoryListTable).select().eq("type", value: category.rawValue).execute().value
            return categoryItems
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func fetchRecipe(id: UUID) async -> Recipe? {
        do {
            let recipe: [Recipe] = try await instance.from(Constants.kRecipesTable).select().eq("id", value: id).execute().value
            return recipe.first
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func fetchRecipes() async -> [Recipe]? {
        do {
            let recipes: [Recipe] = try await instance.from(Constants.kRecipesTable).select().execute().value
            return recipes
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
