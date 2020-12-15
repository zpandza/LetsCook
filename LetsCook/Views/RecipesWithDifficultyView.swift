//
//  RecipesWithDifficultyView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 13.12.2020..
//

import SwiftUI



struct RecipesWithDifficultyView: View {
    
    var recipeViewModel: RecipeViewModel
    var loginViewModel: LoginViewModel
    var selectedDifficulty: String
    
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(recipeViewModel.getFilteredListByDifficulty(difficulty: selectedDifficulty)){ recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel)){
                        SearchRowView(recipe: recipe)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct RecipesWithDifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesWithDifficultyView(recipeViewModel: RecipeViewModel(), loginViewModel: LoginViewModel(), selectedDifficulty: "easy")
    }
}
