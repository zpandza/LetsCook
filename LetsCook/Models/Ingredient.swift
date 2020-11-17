//
//  Ingredient.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import Foundation

struct Ingredient: Codable, Identifiable {
    var id = UUID()
    let name: String
    let proteins: Double
    let carbs: Double
    let fats: Double
//    var isDisliked: Bool = false
    
    var calories: Double {
        return proteins * 4 + carbs * 4 + fats * 9
    }
}

