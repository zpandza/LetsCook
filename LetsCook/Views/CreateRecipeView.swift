//
//  CreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

/*
 ProgressBar
 1st page - Name, Description, Difficulty, CuisineType, CookingDuration
 2nd page - ignredients
 3rd page - tutorial
 4th page - image
 */

struct CreateRecipeView: View {
    
    @StateObject var viewModel: CreateRecipeViewModel = CreateRecipeViewModel()
    
    var body: some View {
        VStack{
            ProgressView("Progress...", value: viewModel.currentProgress, total: 100)
                .padding()
            VStack {
                if viewModel.currentPage == 0 {
                    FirstCreateRecipeView(viewModel: viewModel)
                } else if viewModel.currentPage == 1 {
                    SecondCreateRecipeView(viewModel: viewModel)
                } else if viewModel.currentPage == 2 {
                    ThirdCreateRecipeView(viewModel: viewModel)
                } else if viewModel.currentPage == 3 {
                    ForthCreateRecipeView(viewModel: viewModel)
                } else {
                    Text("Thanks for your recipe :-)")
                }
            }
            Spacer()
        }
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
