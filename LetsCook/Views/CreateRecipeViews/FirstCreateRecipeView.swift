//
//  FirstCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct FirstCreateRecipeView: View {
    
    var viewModel: CreateRecipeViewModel
    
    var body: some View {
        Text("First")
        
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

struct FirstCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
