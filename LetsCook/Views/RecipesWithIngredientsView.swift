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
    var ingredients: [Ingredient]
    
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(recipeViewModel.getFilteredListByIngredients(ingredients: ingredients)){ recipe in
                    Text(recipe.name)
                }
            }
        }
    }
}

struct RecipesWithIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesWithIngredientsView(recipeViewModel: RecipeViewModel(), ingredients: [])
    }
}
