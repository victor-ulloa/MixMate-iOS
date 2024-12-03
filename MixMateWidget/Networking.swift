//
//  Networking.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-11-20.
//

import Foundation
import Supabase

class Networking {
    
    static let kCocktailsTable = ""
    
    
    func fetchCocktails() async -> [Cocktail]? {
        guard let url = URL(string: "https://npcddrdidmrwljkyxolk.supabase.co") else {
            fatalError("Failed to initialize Supabase")
        }
        let instance = SupabaseClient(supabaseURL: url, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wY2RkcmRpZG1yd2xqa3l4b2xrIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxODA2NTk2NCwiZXhwIjoyMDMzNjQxOTY0fQ.iHielmKxMmxEojHD7DjdScOLfbUWtLO2mZlcFi-S66Q")
        
        do {
            let fetchedCocktails: [Cocktail] = try await instance.from("cocktails").select().execute().value
            print(fetchedCocktails)
            return fetchedCocktails
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
}


struct Cocktail: Codable, Hashable {
    
    let id: Int
    let name: String?
    let shortDescription: String?
    let imageURL: String?
    let recipe: UUID?
    
}
