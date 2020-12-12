//
//  ForthCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct ForthCreateRecipeView: View {
    
    var viewModel: CreateRecipeViewModel
    
    var body: some View {
        Text("Forth")
        
        Button(action: {
            viewModel.currentPage += 1
            viewModel.currentProgress += 25
        }){
            Text("Finish")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.blue))
        .foregroundColor(.white)
    }
}

struct ForthCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ForthCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
