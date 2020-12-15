//
//  EditRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 14.12.2020..
//

import SwiftUI

struct EditRecipeView: View {
    
    var recipe: Recipe
    
    @ObservedObject var viewModel: CreateRecipeViewModel = CreateRecipeViewModel()
    
    @State private var selectedDifficultyIndex: Int = 0
    let difficulties = ["Easy", "Medium", "Hard"]
    
    @State private var selectedCuisineIndex = 0
    let cuisines = ["Asian", "BBQ", "Italian", "American", "Balkan", "Chinese", "Indian", "European"]

    var body: some View {
                Form {
                    Section(header: Text("Recipe name")) {
                        TextField("Enter recipe name", text: $viewModel.recipeName)
                    }
                    
                    Section(header: Text("Description")) {
                        TextField("Enter recipe description", text: $viewModel.recipeDescription)
                    }
                    Section(header: Text("Difficulty")) {
                        Picker(selection: $selectedDifficultyIndex, label: Text("")){
                            ForEach(0 ..< difficulties.count) {
                                Text(difficulties[$0])
                                
                            }
                        }
                    }
                    
                    Section(header: Text("Cuisine")){
                        Picker(selection: $selectedCuisineIndex, label: Text("")){
                            ForEach(0 ..< cuisines.count) {
                                Text(cuisines[$0])
                            }
                        }
                    }
                    
                    Section(header: Text("Cooking duration")) {
                        TextField("Enter Cooking duration(min)", text: $viewModel.recipeCookingDuration)
                            .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("Tutorial")) {
                        TextField("Tutorial", text: $viewModel.tutorial)
                    }
                }.onAppear {
                    
                    
                    viewModel.recipeName = recipe.name
                    viewModel.recipeDescription = recipe.description
                    viewModel.recipeDifficulty = recipe.difficulty
                    viewModel.recipeCuisineType = recipe.cuisineType
                    viewModel.recipeCookingDuration = recipe.cookingDuration
                    viewModel.ingredients = recipe.ingredients
                    viewModel.tutorial = recipe.tutorial
                    viewModel.imageName = recipe.image
                }
                
            Button(action: {
                viewModel.recipeDifficulty = RecipeDifficulty(rawValue: selectedDifficultyIndex+1) ?? .easy
                viewModel.recipeCuisineType = Cuisine(rawValue: selectedCuisineIndex+1) ?? .american
                viewModel.updateRecipe()
            }){
                Text("Update")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green).opacity(0.7))
            .foregroundColor(.white)
        }
}
