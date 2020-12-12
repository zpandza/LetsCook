//
//  SecondCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct SecondCreateRecipeView: View {
    
    var viewModel: CreateRecipeViewModel

    var body: some View {
        Text("Second")
        
        Button(action: {
            viewModel.currentPage += 1
            viewModel.currentProgress += 25
        }){
            Text("Next")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.blue))
        .foregroundColor(.white)
    }
}

struct SecondCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SecondCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
