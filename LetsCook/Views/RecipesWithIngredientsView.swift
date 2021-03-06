//
//  RecipesWithIngredientsView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct RecipesWithIngredientsView: View {
    
//    var data: [Recipe]
    var recipeViewModel: RecipeViewModel
    var loginViewModel: LoginViewModel
    var ingredients: [String]
    
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(recipeViewModel.getFilteredListByIngredients(ingredients: ingredients)){ recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel)){
                        SearchRowView(recipe: recipe)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct RecipesWithIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesWithIngredientsView(recipeViewModel: RecipeViewModel(), loginViewModel: LoginViewModel(), ingredients: [])
    }
}
