//
//  YourRecipesView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 14.12.2020..
//

import SwiftUI

struct YourRecipesView: View {
    
    @StateObject var loginViewModel: LoginViewModel
    
    var body: some View {
        List {
            ForEach(loginViewModel.usersRecipes){ recipe in
                HStack {
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel, isEditable: true)){
                        SearchRowView(recipe: recipe)
                            .padding(.horizontal)
                    }
                    
                }
                Button(action: {
                    loginViewModel.deleteRecipe(recipe: recipe)
                }) {
                    Image(systemName: "trash.fill")
                }
            }
        }.onAppear {
            loginViewModel.getUsersRecipes()
        }
    }
}

struct YourRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        YourRecipesView(loginViewModel: LoginViewModel())
    }
}
