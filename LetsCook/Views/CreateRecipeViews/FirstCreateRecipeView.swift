//
//  FirstCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct FirstCreateRecipeView: View {
    
    @StateObject var viewModel: CreateRecipeViewModel
    
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
            Section{
                Button(action: {
                viewModel.currentPage += 1
                viewModel.currentProgress += 25
                viewModel.recipeDifficulty = RecipeDifficulty(rawValue: selectedDifficultyIndex+1) ?? .easy
                viewModel.recipeCuisineType = Cuisine(rawValue: selectedCuisineIndex+1) ?? .american
            }){
                Text("Next")
            }
            }
        }
        
        
    }
}

struct FirstCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
