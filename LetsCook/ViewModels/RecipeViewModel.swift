//
//  TemporaryData.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published private(set) var recipeData: [Recipe] = []
    @Published var searchRecipeValue: String = ""

    func getFilteredListByIngredients(ingredients: [Ingredient]) -> [Recipe] {
        
        var tempData: [Recipe] = []
        
        var dummy: [Ingredient] = []
                
        recipeData.forEach { recipe in
            recipe.ingredients.forEach { recipeIngredient in
                if ingredients.count > 1 {
                    ingredients.forEach { ingredient in
                        if ingredient.name == recipeIngredient.name {
                            dummy.append(ingredient)
                            if dummy.count == ingredients.count {
                                tempData.append(recipe)
                            }
                        }
                    }
                }
                else {
                        if ingredients[0].name == recipeIngredient.name {
                            tempData.append(recipe)
                        }
                }
            }
        }
        
        return tempData
    }
//    private func getRecipeData(){
        let data = [
            Recipe(name: "Hot Dog", image: "hotdog", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
                   difficulty: .easy, cookingDuration: 30, ingredients: [
                    Ingredient(name: "Nesto", proteins: 4, carbs: 10, fats: 10),
                    Ingredient(name: "Ketchup", proteins: 2, carbs: 14, fats: 0),
                   ],
                   tutorial: "Put the sausage in the bun then add ketchup and mustard", cuisineType: .italian),
//            Recipe(name: "Pizza", image: "pizza", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
//                   difficulty: .medium, cookingDuration: 40, ingredients: ["150g Ham", "150g Cheese", "Mushrooms", "Ketchup", "Origano"],
//                   tutorial: "Some description Some description Some description Some description Some description Some description Some descriptiona", cuisineType: .italian),
//            Recipe(name: "Hamburger", image: "hamburger", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
//                   difficulty: .easy, cookingDuration: 50, ingredients: ["1 Bun", "1 Burger Patty", "Tomato", "Salad", "Ketchup"],
//                   tutorial: "Some description Some description Some description Some description Some description", cuisineType: .asian),
//            Recipe(name: "Cheeseburger", image: "cheeseburger", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
//                   difficulty: .medium, cookingDuration: 60, ingredients: ["1 Bun", "1 Burger Patty", "Tomato", "Salad", "Ketchup", "2 slices of cheese"],
//                   tutorial: "Some description Some description Some description Some description Some description Some description Some description ", cuisineType: .bbq),
//            Recipe(name: "Buhac", image: "buhac", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.  ",
//                   difficulty: .hard, cookingDuration: 69, ingredients: ["Lucija", "Roba", "Sanja", ""],
//                   tutorial: "kralj", cuisineType: .italian),
        ]
//    }
    
    func filterList() {
        var tempData: [Recipe]
        if searchRecipeValue != "" {
            tempData = recipeData.filter { (recipe) -> Bool in
                return recipe.name.lowercased().starts(with: searchRecipeValue.lowercased())
            }
        } else {
            tempData = data
        }
        
        recipeData = tempData
    }
    
    private func getRecipeData() {
        recipeData = data
    }
    
    init(){
        getRecipeData()
    }
    
    
}
