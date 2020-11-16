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
    
    private var navTitle: String {
        switch selectedTab {
        case 1:
            return "Recipes"
        case 2:
            return "Settings"
        default:
            return ""
        }
    }
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedTab){
                RecipeView(data: recipeViewModel.recipeData)
                    .tag(1)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Recipes")
                    }
                SettingsView(viewModel: viewModel)
                    .tag(2)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }.navigationTitle(navTitle)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: LoginViewModel())
    }
}
