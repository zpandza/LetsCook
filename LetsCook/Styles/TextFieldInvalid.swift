//
//  TextFieldInvalid.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 08.12.2020..
//

import SwiftUI

struct TextFieldInvalid: TextFieldStyle {
    
    var isValid: Bool = true
        
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding()
                .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
                .autocapitalization(.words)
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(isValid ? Color.black : Color.red, lineWidth: 0.5)
                )
                .padding(.bottom, 10)
        }
    
}

struct RecipeTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
            .padding(.bottom, 10)
    }
}

