//
//  SecondCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI

struct SecondCreateRecipeView: View {
    
    @StateObject var viewModel: CreateRecipeViewModel
    @StateObject var ingredientViewModel = IngredientViewModel()
    
    
    @State private var selectedIngredientIndex: Int = 0
    @State private var selectedMeasureUnit: Int = 0
    @State private var amount: String = ""
    let measureUnits = ["g", "ml", "tbsp", "buhac", "pieces"]
    
    
    var body: some View {
        
        Form {
            Section {
                Picker(selection: $selectedIngredientIndex, label: Text("")){
                    ForEach(0 ..< ingredientViewModel.ingredientData.count) {
                        Text(ingredientViewModel.ingredientData[$0])
                    }
                }
            }
            Section {
                Picker(selection: $selectedMeasureUnit, label: Text("")){
                    ForEach(0 ..< measureUnits.count) {
                        Text(measureUnits[$0])
                    }
                }
            }
            Section {
                TextField("Enter amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            Section {
                Button(action: {
                    viewModel.ingredients.append("\(amount) \(measureUnits[selectedMeasureUnit]) \(ingredientViewModel.ingredientData[selectedIngredientIndex])")
                    
                    selectedMeasureUnit = 0
                    selectedIngredientIndex = 0
                    amount = ""
                }){
                    Text("Select ingredient")
                }
            }
            
        }.frame(height: screenHeight * 0.4)
        
        List{
            ForEach(viewModel.ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
        }
        
        Button(action: {
            viewModel.currentPage += 1
            viewModel.currentProgress += 25
        }){
            Text("Next")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green).opacity(0.8))
        .foregroundColor(.white)
    }
}

struct SecondCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SecondCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
