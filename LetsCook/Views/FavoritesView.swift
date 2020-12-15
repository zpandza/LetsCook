//
//  FavoritesView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var loginViewModel: LoginViewModel
    
    var body: some View {
        List{
            ForEach(loginViewModel.favoriteRecipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel)){
                    SearchRowView(recipe: recipe)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(loginViewModel: LoginViewModel())
    }
}
