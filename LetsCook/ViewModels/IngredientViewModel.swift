//
//  IngredientViewModel.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import Foundation

class IngredientViewModel: ObservableObject {
    @Published var ingredientData: [Ingredient] = []
    @Published var filterString: String = ""
    
    let data = [
        Ingredient(name: "Egg", proteins: 13, carbs: 0.7, fats: 9.5),
        Ingredient(name: "Bun", proteins: 4, carbs: 28, fats: 2),
        Ingredient(name: "Hamburger patty", proteins: 16, carbs: 3, fats: 20),
        Ingredient(name: "Ketchup", proteins: 2, carbs: 14, fats: 0),
        Ingredient(name: "Tomato", proteins: 0, carbs: 0, fats: 0),
        Ingredient(name: "Salad", proteins: 0, carbs: 0, fats: 0)
    ]
    
    func filterList() {
        var tempData: [Ingredient]
        if filterString != "" {
            tempData = ingredientData.filter { (ingredient) -> Bool in
                return ingredient.name.lowercased().starts(with: filterString.lowercased())
            }
        } else {
            tempData = data
        }
        
        ingredientData = tempData
    }
    
    init(){
        getData()
    }
    
    private func getData(){
        ingredientData = data
    }
}
