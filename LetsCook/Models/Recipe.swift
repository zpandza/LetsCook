//
//  Recipe.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import Foundation

import Foundation

typealias Codable = Encodable & Decodable

struct Recipe: Codable, Identifiable {
    var id = UUID()
    let name: String
    let image: String
    let description: String
    let difficulty: RecipeDifficulty
    let cookingDuration: Int
    let ingredients: [String]
    let tutorial: String
}

enum RecipeDifficulty: Int, CustomStringConvertible, Codable {
    
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
