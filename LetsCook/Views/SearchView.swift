//
//  SearchView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct SearchView: View {
    
    @State private var selectedPickerValue: Int = 0
    @State private var searchRecipeValue: String = ""
    @State private var searchIngredientValue: String = ""
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    @StateObject var ingredientViewModel: IngredientViewModel = IngredientViewModel()
    
    
    @State private var searchIngredientsClicked: Bool = false
    
    var body: some View {
        
        
        
        VStack{
            Picker("", selection: $selectedPickerValue){
                Text("Name").tag(0)
                Text("Ingredient").tag(1)
                Text("Skill").tag(2)
                Text("Cuisine").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
            VStack(){
                if selectedPickerValue == 0 {
                    TextField("Search recipes...", text: $recipeViewModel.searchRecipeValue)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.gray))
                        .foregroundColor(.black)
                        .padding()
                        .onChange(of: recipeViewModel.searchRecipeValue, perform: { value in
                            recipeViewModel.filterList()
                        })
                    ScrollView {
                        LazyVStack {
                            ForEach(recipeViewModel.recipeData) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)){
                                    HStack {
                                        Image(recipe.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: screenWidth * 0.2, height: 85)
                                            .cornerRadius(10)
                                        Text(recipe.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        //Text(rating) TODO
                                        Spacer()
                                    }.padding(.horizontal)
                                }
                            }
                        }
                    }
                } else {
                    TextField("Search Ingredients...", text: $ingredientViewModel.filterString)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.gray))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .onChange(of: ingredientViewModel.filterString, perform: { value in
                            ingredientViewModel.filterList()
                        })
                    List {
                        ForEach(ingredientViewModel.ingredientData){ ingredient in
                            HStack {
                                Text(ingredient.name)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: ingredientViewModel.isIngredientSelected(ingredient: ingredient) ? "checkmark" : "")
                            }.onTapGesture {
                                ingredientViewModel.toggleIngredient(ingredient: ingredient)
                                print(ingredient.name)
                            }
                        }
                    }
                    
                    Button(action: {
                        searchIngredientsClicked = true
                    }) {
                        Text("Search for recipe")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.blue))
                    .foregroundColor(.white)
                }
            }
            NavigationLink(destination: RecipesWithIngredientsView(recipeViewModel: recipeViewModel, ingredients: ingredientViewModel.selectedIngredients),
                           isActive: $searchIngredientsClicked){EmptyView()}
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(recipeViewModel: RecipeViewModel())
    }
}
