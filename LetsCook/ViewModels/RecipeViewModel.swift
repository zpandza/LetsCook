//
//  TemporaryData.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published private(set) var recipeData: [Recipe] = []
    
    private func getRecipeData(){
        recipeData = [
            Recipe(name: "Hot Dog", image: "hotdog", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
                   difficulty: .easy, cookingDuration: 30, ingredients: ["1 Bun", "1 Sausage", "Mustard", "Ketchup"],
                   tutorial: "Put the sausage in the bun then add ketchup and mustard", cuisineType: .italian),
            Recipe(name: "Pizza", image: "pizza", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
                   difficulty: .medium, cookingDuration: 40, ingredients: ["150g Ham", "150g Cheese", "Mushrooms", "Ketchup", "Origano"],
                   tutorial: "Some description Some description Some description Some description Some description Some description Some descriptiona", cuisineType: .italian),
            Recipe(name: "Hamburger", image: "hamburger", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
                   difficulty: .easy, cookingDuration: 50, ingredients: ["1 Bun", "1 Burger Patty", "Tomato", "Salad", "Ketchup"],
                   tutorial: "Some description Some description Some description Some description Some description", cuisineType: .asian),
            Recipe(name: "Cheeseburger", image: "cheeseburger", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.",
                   difficulty: .medium, cookingDuration: 60, ingredients: ["1 Bun", "1 Burger Patty", "Tomato", "Salad", "Ketchup", "2 slices of cheese"],
                   tutorial: "Some description Some description Some description Some description Some description Some description Some description ", cuisineType: .bbq),
            Recipe(name: "Buhac", image: "buhac", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam enim justo, vulputate ut tortor id, fermentum vulputate justo. Cras tristique tellus nec nulla porttitor, sed fringilla turpis hendrerit. Suspendisse sagittis vestibulum magna et convallis. Curabitur vulputate dolor in velit convallis sagittis. Suspendisse potenti.  ",
                   difficulty: .hard, cookingDuration: 69, ingredients: ["Lucija", "Roba", "Sanja", ""],
                   tutorial: "kralj", cuisineType: .italian),
        ]
    }
    
    init(){
        getRecipeData()
    }
    
    
}
