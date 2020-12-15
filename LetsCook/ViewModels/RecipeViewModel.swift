//
//  TemporaryData.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import Foundation
import FirebaseFirestore

class RecipeViewModel: ObservableObject {
    
    let db = Firestore.firestore()

    
    @Published private(set) var recipeData: [Recipe] = []
    @Published var searchRecipeValue: String = ""

    
    func getFilteredListByCuisine(cuisineType: Int) -> [Recipe] {
        var tempData: [Recipe] = []
        recipeData.forEach { recipe in
            if recipe.cuisineType.rawValue == cuisineType {
                tempData.append(recipe)
            }
        }
        return tempData
    }
    
    func getFilteredListByDifficulty(difficulty: String) -> [Recipe] {
        var tempData: [Recipe] = []
        recipeData.forEach { recipe in
            if recipe.difficulty.description == difficulty {
                tempData.append(recipe)
            }
        }
        return tempData
    }
    
    func getFilteredListByIngredients(ingredients: [String]) -> [Recipe] {
        
        var tempData: [Recipe] = []
        
        var dummy: [String] = []
    
        recipeData.forEach { recipe in
            recipe.ingredients.forEach { recipeIngredient in
                if ingredients.count > 1 {
                    ingredients.forEach { ingredient in
                        if recipeIngredient.contains(ingredient) {
                            dummy.append(ingredient)
                            if dummy.count == ingredients.count {
                                tempData.append(recipe)
                            }
                        }
                    }
                }
                else {
                    if recipeIngredient.contains(ingredients[0]) {
                            tempData.append(recipe)
                        }
                }
            }
        }
        
        return tempData
    }
    
    func filterList() {
        var tempData: [Recipe]
        if searchRecipeValue != "" {
            tempData = recipeData.filter { (recipe) -> Bool in
                return recipe.name.lowercased().starts(with: searchRecipeValue.lowercased())
            }
        } else {
            getRecipeData()
            tempData = recipeData
        }
        
        recipeData = tempData
    }
    
    private func getRecipeData() {
        
        db.collection("recipes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
              print("No documents")
              return
            }

            self.recipeData = documents.map { queryDocumentSnapshot -> Recipe in
                let data = queryDocumentSnapshot.data()
//                print(data)
                
                let name = data["name"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let difficulty = data["difficulty"] as? Int ?? 1
                let cookingDuration = data["cookingDuration"] as? String ?? ""
                let ingredients = data["ingredients"] as? [String] ?? []
                let tutorial = data["tutorial"] as? String ?? ""
                let cuisineType = data["cuisineType"] as? Int ?? 1
                let createdBy = data["createdBy"] as? String ?? "zvone.pandzaa@gmail.com"
                
                return Recipe(name: name, image: image, description: description, difficulty: RecipeDifficulty(rawValue: difficulty)!, cookingDuration: cookingDuration, ingredients: ingredients, tutorial: tutorial, cuisineType: Cuisine(rawValue: cuisineType)!, createdBy: createdBy)
            }
          }
        
        }
    
    init(){
        getRecipeData()
    }
    
    
}
