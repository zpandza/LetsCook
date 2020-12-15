//
//  Recipe.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import Foundation


struct Recipe: Codable, Identifiable {
    var id = UUID()
    let name: String 
    let image: String
    let description: String
    let difficulty: RecipeDifficulty
    let cookingDuration: String
    let ingredients: [String]
    let tutorial: String
    let cuisineType: Cuisine
    let createdBy: String
}

enum Cuisine: Int, CustomStringConvertible, Codable{
    
    
    
    case asian = 1
    case bbq = 2
    case italian = 3
    case american = 4
    case balkan = 5
    case chinese = 6
    case indian = 7
    case european = 8
            
    var description: String {
        switch self {
        case .asian:
            return "Asian"
        case .bbq:
            return "BBQ"
        case .italian:
            return "Italian"
        case .american:
            return "American"
        case .balkan:
            return "Balkan"
        case .chinese:
            return "Chinese"
        case .indian:
            return "Indian"
        case .european:
            return "European"
        }
    }
}

enum RecipeDifficulty: Int, CustomStringConvertible, Codable{
    
    case easy = 1
    case medium = 2
    case hard = 3
    
    var description: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
}
