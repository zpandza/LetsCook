//
//  RecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct RecipeView: View {
    
    @StateObject var loginViewModel: LoginViewModel
    var data: [Recipe] = []
    let storage = Storage.storage()
    
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
        ScrollView {
            VStack(alignment: .leading){
                Text("Latest Recipes")
                    .font(.title)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15){
                        ForEach(data) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: loginViewModel)){
                                RecipeCardView(recipe: recipe)
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
        RecipeView(loginViewModel: LoginViewModel())
    }
}
