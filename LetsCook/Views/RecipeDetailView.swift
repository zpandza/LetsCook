//
//  RecipeDetailView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    @StateObject var viewModel: LoginViewModel
    
    @State private var imageUrl = ""
    @State private var editIsToggled: Bool = false
    var isEditable: Bool?
    
    func getImageUrl(recipe: Recipe){
        
        let storageRef = Storage.storage().reference(withPath: recipe.image)
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.imageUrl = url?.absoluteString ?? "something_went_wrong"
        }
        print(imageUrl)
    }
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: EditRecipeView(recipe: recipe), isActive: $editIsToggled){
                EmptyView()
            }
            VStack(alignment: .leading, spacing: 10){
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .frame(width: screenWidth, height: screenHeight * 0.3)
                
                HStack {
                    Text(recipe.name)
                        .font(.title)
                        .padding()
                    Spacer()
                    if(isEditable ?? false){
                        Image(systemName: "pencil")
                            .font(.system(size: 40))
                            .onTapGesture {
                                editIsToggled.toggle()
                            }
                    }
                    Image(systemName: "heart")
                        .font(.system(size: 40))
                        .onTapGesture {
                            viewModel.toggleFavoriteFood(recipe: recipe)
                        }.padding(.trailing)
                }
                
                
                Text("Recipe Description")
                    .font(.headline)
                    .padding(.horizontal)
                
                Text(recipe.description)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                Text("Difficulty")
                    .font(.headline)
                    .padding(.horizontal)
                Text("\(recipe.difficulty.description)")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                Group{
                    Text("Duration")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("\(recipe.cookingDuration) minutes")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                Text("Ingredients")
                    .font(.headline)
                    .padding(.horizontal)
                
                ForEach(recipe.ingredients, id: \.self){ ingredient in
                    Text(ingredient)
                        .font(.subheadline)
                        .padding(.horizontal, 40)
                        .padding(.bottom)
                }
                Group{
                    Text("Tutorial")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("\(recipe.tutorial)")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }.onAppear {
                getImageUrl(recipe: recipe)
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(name: "Buhac", image: "hamburger",
                                        description: "Description of recipe",
                                        difficulty: .hard, cookingDuration: "69",
                                        ingredients: ["100g Roba", "100ml Sanja", "2tbsp Luca"],
                                        tutorial: "kralj", cuisineType: .bbq, createdBy: "zvone.pandzaa@gmail.com"), viewModel: LoginViewModel())
    }
}
