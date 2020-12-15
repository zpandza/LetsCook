//
//  RecipeCardView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 14.12.2020..
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct RecipeCardView: View {
    
    var recipe: Recipe
    
    @State private var imageUrl = ""
    
    func getImageUrl(recipe: Recipe) {
        
        let storageRef = Storage.storage().reference(withPath: recipe.image)
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.imageUrl = url?.absoluteString ?? "something_went_wrong"
        }
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            WebImage(url: URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0,
                       maxWidth: 150,
                       minHeight: 0,
                       maxHeight: 200)
                .cornerRadius(10)
                .onAppear {
                    getImageUrl(recipe: recipe)
                }
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}
