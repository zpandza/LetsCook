//
//  RecipeDetailView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10){
                    Image(recipe.image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: screenWidth, minHeight: 0, maxHeight: 250)

                    Text(recipe.name)
                        .font(.title)
                        .padding()
                    
                    Text("Recipe Description")
                        .font(.title)
                        .padding(.horizontal)
                
                    Text(recipe.description)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("Difficulty: \(recipe.difficulty.description)")
                        .font(.title)
                        .padding()

                    Text("Duration: \(recipe.cookingDuration) minutes")
                        .font(.title)
                        .padding()

                    Text("Ingredients")
                        .font(.title)
                        .padding(.top)
                        .padding(.horizontal)

                    ForEach(recipe.ingredients, id: \.self){ ingredient in
                        Text(ingredient)
                            .font(.headline)
                            .padding(.horizontal)
                    }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(name: "Buhac", image: "hamburger",
                                        description: "Description of recipe",
                                        difficulty: .hard, cookingDuration: 69,
                                        ingredients: ["Lucija", "Roba", "Sanja"],
                                        tutorial: "kralj", cuisineType: .bbq))
    }
}
