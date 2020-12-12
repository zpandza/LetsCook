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
    @Published var selectedIngredients: [Ingredient] = []

    let data = [
        Ingredient(name: "Egg", proteins: 13, carbs: 0.7, fats: 9.5),
        Ingredient(name: "Bun", proteins: 4, carbs: 28, fats: 2),
        Ingredient(name: "Hamburger patty", proteins: 16, carbs: 3, fats: 20),
        Ingredient(name: "Ketchup", proteins: 2, carbs: 14, fats: 0),
        Ingredient(name: "Tomato", proteins: 0, carbs: 0, fats: 0),
        Ingredient(name: "Salad", proteins: 0, carbs: 0, fats: 0),
        Ingredient(name: "Nesto", proteins: 4, carbs: 10, fats: 10)
    ]
//    func toggleDislikedFood(ingredient: Ingredient) {
//        if let index = dislikedFood.firstIndex(where: {
//            $0.name == ingredient.name
//        }){
//            dislikedFood.remove(at: index)
//            return
//        }
//        dislikedFood.append(ingredient)
//    }
    
    func toggleIngredient(ingredient: Ingredient) {
        if let index = selectedIngredients.firstIndex(where: {
            $0.name == ingredient.name
        }){
            selectedIngredients.remove(at: index)
            return
        }
        selectedIngredients.append(ingredient)
    }
    
    func isIngredientSelected(ingredient: Ingredient) -> Bool{
        if selectedIngredients.contains(where: {
            return $0.name == ingredient.name
        }){
            return true
        }
        return false
    }
    
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
