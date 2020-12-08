//
//  SignUpValidation.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 08.12.2020..
//

import Foundation
import SwiftUI

struct SignUpValidation {
    
    var viewModel: LoginViewModel
    @Binding var validationState: SignUpFormF.ValidationState?
    
    func fullNameValid() -> Bool {
        if viewModel.signUpFullName != "" {
            return true
        }
        return false
    }
    
    func emailValid() -> Bool {
        if viewModel.signUpEmail.count > 55 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: viewModel.signUpEmail)
        
        
    }
    
    func passwordValid() -> Bool {
        let pass = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        
        return pass.evaluate(with: viewModel.signUpPassword)
    }
    
    func repeatPasswordValid() -> Bool {
        return viewModel.signUpPassword == viewModel.signUpPasswordRepeat
    }
    
    func firstPageEmpty() -> Bool {
        if (viewModel.signUpFullName == "" || viewModel.signUpEmail == "" || viewModel.signUpPassword == "" || viewModel.signUpPasswordRepeat == "") {
            return true
        }
        return false
    }
    
    func firstFormValid() -> Bool {
        if fullNameValid() && emailValid() && passwordValid() && repeatPasswordValid() {
            return true
        }
        if fullNameValid() {
            if emailValid() {
                if passwordValid() {
                    if repeatPasswordValid() {
                        return true
                    } else {
                        validationState = SignUpFormF.ValidationState(errorMessage: "Repeat password invalid!", errorDescription: "Repeat password must match password.")
//                        SignUpFormF.ValidationState.init(errorMessage: "Repeat password invalid!", errorDescription: "Repeat password must match password.")
                    }
                } else {
                    validationState = SignUpFormF.ValidationState(errorMessage: "Password invalid!", errorDescription: "Password must containt minimum 8 characters, capital letter and a special character")
//                    SignUpFormF.ValidationState.init(errorMessage: "Password invalid!", errorDescription: "Password must containt minimum 8 characters, capital letter and a special character")
                }
            } else {
                validationState = SignUpFormF.ValidationState(errorMessage: "Email invalid!", errorDescription: "Email must be formatted correctly.")
//                SignUpFormF.ValidationState.init(errorMessage: "Email invalid!", errorDescription: "Email must be formatted correctly.")
            }
        } else {
            validationState = SignUpFormF.ValidationState(errorMessage: "Full name invalid!", errorDescription: "Full name must be valid.")

//            SignUpFormF.ValidationState.init(errorMessage: "Full name invalid!", errorDescription: "Full name must be valid.")
        }
        return false
    }
}
