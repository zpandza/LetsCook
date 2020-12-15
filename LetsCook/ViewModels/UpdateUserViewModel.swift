//
//  UpdateUserViewModel.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 14.12.2020..
//

import Foundation

final class UpdateUserViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var favoriteCuisine: Cuisine?
    
}
