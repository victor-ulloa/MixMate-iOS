//
//  Cocktail.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-10.
//

import Foundation

struct Cocktail: Codable, Identifiable{
    
    var id: Int
    let name: String?
    let shortDescription: String?
    let imageName: String?
    let imageURL: String?
    
}
