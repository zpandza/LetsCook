//
//  RecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI

struct RecipeView: View {
    
    var data: [Recipe] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text("Latest Recipes")
                    .font(.title)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15){
                        ForEach(data) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)){
                                VStack(alignment: .leading, spacing: 5){
                                    Image(recipe.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0,
                                               maxWidth: 150,
                                               minHeight: 0,
                                               maxHeight: 200)
                                        .cornerRadius(10)
                                    Text(recipe.name)
                                        .font(.headline)
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
            }.padding()
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
