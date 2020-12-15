//
//  RecipesWithCuisineView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 13.12.2020..
//

import SwiftUI

struct RecipesWithCuisineView: View {
    
    var recipeViewModel: RecipeViewModel
    var loginViewModel: LoginViewModel
    var cuisineType: Int
    
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(recipeViewModel.getFilteredListByCuisine(cuisineType: cuisineType)){ recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel)){
                        SearchRowView(recipe: recipe)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct RecipesWithCuisineView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesWithCuisineView(recipeViewModel: RecipeViewModel(), loginViewModel: LoginViewModel(), cuisineType: 1)
    }
}
