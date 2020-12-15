//
//  HomeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI



struct HomeView: View {
    
    @StateObject var viewModel: LoginViewModel
    @ObservedObject var recipeViewModel: RecipeViewModel = RecipeViewModel()
    
    @State private var selectedTab: Int = 1
    @State private var isCreateRecipeActive: Bool = false
    private var navTitle: String {
        switch selectedTab {
        case 1:
            return "Recipes"
        case 2:
            return "Search"
        case 3:
            return "Create New Recipe"
        case 4:
            return "Favorites"
        case 5:
            return "Settings"
        default:
            return ""
        }
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                TabView(selection: $selectedTab){
                    RecipeView(loginViewModel: viewModel, data: recipeViewModel.recipeData)
                        .tag(1)
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("Recipes")
                        }
                    SearchView(recipeViewModel: recipeViewModel, loginViewModel: viewModel)
                        .tag(2)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    CreateRecipeView()
                        .tag(3)
                        .tabItem {
                            Image(systemName: "plus")
                            Text("Create")
                        }
                    FavoritesView(loginViewModel: viewModel)
                        .tag(4)
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Favorites")
                        }
                    SettingsView(viewModel: viewModel)
                        .tag(5)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }.navigationTitle(navTitle)
            }
//            NavigationLink(destination: CreateRecipeView(), isActive: $isCreateRecipeActive){
//                EmptyView()
//            }
//            Button(action: {
//                isCreateRecipeActive.toggle()
//            }){
//                Image(systemName: "plus")
//            }.background(Circle().frame(width: 60, height: 60).foregroundColor(.blue))
//                .foregroundColor(.white)
//                .offset(x: 0, y: 375)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: LoginViewModel())
    }
}
