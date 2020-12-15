//
//  User.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    let fullName: String
    let email: String
    let password: String
    let favoriteCuisine: Cuisine
    let dislikedFood: [String]
    var favorites: [String]
    @ServerTimestamp var createdTime: Timestamp?
}
