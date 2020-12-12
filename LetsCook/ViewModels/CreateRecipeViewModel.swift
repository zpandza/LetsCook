//
//  CreateRecipeViewModel.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import Foundation

final class CreateRecipeViewModel: ObservableObject {
    @Published var currentProgress: Double = 0.0
    @Published var currentPage: Int = 0
}
