//
//  User.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    let fullName: String
    let email: String
    let password: String
    let favoriteCuisine: Cuisine
    let alergies: [String]
    let dislikedFood: [String]
}
