//
//  IngredientViewModel.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import Foundation

class IngredientViewModel: ObservableObject {
    @Published var ingredientData: [String] = []
    @Published var filterString: String = ""
    @Published var selectedIngredients: [String] = []
    
    let data = ["Mayonnaise", "Ketchup", "Mustard", "Green salad", "Tomato", "Mushrooms", "Spinach", "Carrot", "Onion", "Garlic", "Ginger", "Peas", "Chicken", "Turkey", "Duck", "Beef", "Goose", "Pork", "Lamb", "Shrimp", "Squid", "Lobster", "Clam", "Trout", "Butter", "Salt", "Pepper", "Milk", "Yogurt", "Cheese", "Ham", "Bun", "Egg", "Pasta", "Flour", "Lemon", "Sugar", "Rice", "Cereals", "Chocolate", "Bread", "Potato", "Orange", "Noodles"]
    
    func toggleIngredient(ingredient: String) {
        if let index = selectedIngredients.firstIndex(where: {
            $0 == ingredient
        }){
            selectedIngredients.remove(at: index)
            return
        }
        selectedIngredients.append(ingredient)
    }
    
    func isIngredientSelected(ingredient: String) -> Bool{
        if selectedIngredients.contains(where: {
            return $0 == ingredient
        }){
            return true
        }
        return false
    }
    
    func filterList() {
        var tempData: [String]
        if filterString != "" {
            tempData = ingredientData.filter { (ingredient) -> Bool in
                return ingredient.lowercased().starts(with: filterString.lowercased())
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
