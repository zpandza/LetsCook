//
//  SearchRowView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 14.12.2020..
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct SearchRowView: View {
    
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
    
    var recipe: Recipe
    @State private var imageUrl = ""

    var body: some View {
        HStack {
            WebImage(url: URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth * 0.2, height: 85)
                .cornerRadius(10)
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
        }.onAppear {
            getImageUrl(recipe: recipe)
        }
    }
}

//struct SearchRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchRowView(recipe: <#Recipe#>)
//    }
//}
