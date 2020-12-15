//
//  SearchView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct SearchView: View {
    
    @State private var selectedPickerValue: Int = 0
    @State private var searchRecipeValue: String = ""
    @State private var searchIngredientValue: String = ""
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    @StateObject var ingredientViewModel: IngredientViewModel = IngredientViewModel()
    @StateObject var loginViewModel: LoginViewModel
    
    @State private var selectedDifficultyClicked: Bool = false
    @State private var searchIngredientsClicked: Bool = false
    @State private var searchCuisineClicked: Bool = false

    
    
    @State private var selectedDifficulty: String = ""
    @State private var selectedCuisine = 0

    func getImageUrl(recipe: Recipe) -> String {
        var imageUrl = ""
        
        let storageRef = Storage.storage().reference(withPath: recipe.image)
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            imageUrl = url?.absoluteString ?? "something_went_wrong"
        }
        print(imageUrl)
        return imageUrl
    }
    
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
                        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.gray).opacity(0.3))
                        .foregroundColor(.black)
                        .padding()
                        .onChange(of: recipeViewModel.searchRecipeValue, perform: { value in
                            recipeViewModel.filterList()
                        })
                    ScrollView {
                        LazyVStack {
                            ForEach(recipeViewModel.recipeData) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel)){
                                    SearchRowView(recipe: recipe)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                } else if selectedPickerValue == 1 {
                    TextField("Search Ingredients...", text: $ingredientViewModel.filterString)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.gray).opacity(0.3))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .onChange(of: ingredientViewModel.filterString, perform: { value in
                            ingredientViewModel.filterList()
                        })
                    List {
                        ForEach(ingredientViewModel.ingredientData, id: \.self){ ingredient in
                            HStack {
                                Text(ingredient)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: ingredientViewModel.isIngredientSelected(ingredient: ingredient) ? "checkmark" : "")
                            }.onTapGesture {
                                ingredientViewModel.toggleIngredient(ingredient: ingredient)
                                print(ingredient)
                            }
                        }
                    }
                    
                    Button(action: {
                        searchIngredientsClicked = true
                    }) {
                        Text("Search for recipe")
                    }
                    .disabled(ingredientViewModel.selectedIngredients.count == 0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green).opacity(0.7))
                    .foregroundColor(.white)
                } else if selectedPickerValue == 2 {
                    VStack{
                        Text("Choose preferred difficulty")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .padding(.top)
                        HStack (spacing: 10){
                            //EASY BUTTON
                            Button(action: {
                                selectedDifficulty = "Easy"
                                selectedDifficultyClicked.toggle()
                            }){
                                Text("Easy")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green))
                            
                            //MEDIUM BUTTON
                            Button(action: {
                                selectedDifficulty = "Medium"
                                selectedDifficultyClicked.toggle()
                            }){
                                Text("Medium")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.yellow))

                            //HARD BUTTON
                            Button(action: {
                                selectedDifficulty = "Hard"
                                selectedDifficultyClicked.toggle()
                            }){
                                Text("Hard")
                                    .foregroundColor(.white)
                            }.padding()
                            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.red))
                            
                            
                            
                        }.padding(.vertical)
                        Spacer()
                    }
                } else {
                    
                    let cuisines = ["Asian", "BBQ", "Italian", "American", "Balkan", "Chinese", "Indian", "European"]

                    Form {
                        Section {
                            Picker(selection: $selectedCuisine, label: Text("")){
                                ForEach(0 ..< cuisines.count) {
                                    Text(cuisines[$0])
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        searchCuisineClicked.toggle()
                    }){
                        Text("Search")
                            .foregroundColor(.white)
                    }.padding()
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green).opacity(0.7))
                    
                }
            }
            
            NavigationLink(destination: RecipesWithCuisineView(recipeViewModel: recipeViewModel, loginViewModel: loginViewModel, cuisineType: selectedCuisine + 1), isActive: $searchCuisineClicked){
                EmptyView()
            }
            
            NavigationLink(destination: RecipesWithDifficultyView(recipeViewModel: recipeViewModel, loginViewModel: loginViewModel, selectedDifficulty: selectedDifficulty), isActive: $selectedDifficultyClicked){
                EmptyView()
            }
            
            NavigationLink(destination: RecipesWithIngredientsView(recipeViewModel: recipeViewModel, loginViewModel: loginViewModel, ingredients: ingredientViewModel.selectedIngredients),
                           isActive: $searchIngredientsClicked){EmptyView()}
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(recipeViewModel: RecipeViewModel(), loginViewModel: LoginViewModel())
    }
}
