//
//  ThirdCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct ThirdCreateRecipeView: View {
    
    var viewModel: CreateRecipeViewModel
    
    var body: some View {
        Text("Third")
        
        Button(action: {
            viewModel.currentPage += 1
            viewModel.currentProgress += 25
        }) {
            Text("Next")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.blue))
        .foregroundColor(.white)
    }
}

struct ThirdCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
