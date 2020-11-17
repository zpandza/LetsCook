//
//  LoginViewModel.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import Foundation
import Combine
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isSignUp: Bool = false
    
    //SIGNUP STATES
    @Published var signUpEmail: String = ""
    @Published var signUpPassword: String = ""
    @Published var signUpPasswordRepeat = ""
    @Published var favoriteCousine: Int = 0
    @Published var dislikedFood: [Ingredient] = []
    
    func isFoodDisliked(ingredient: Ingredient) -> Bool {
        if dislikedFood.contains(where: {
            print($0.name)
            print(ingredient.name)
            return $0.name == ingredient.name
        }){
            return true
        }
        return false;
    }
    
    func resetValues(){
        self.signUpEmail = ""
        self.signUpPassword = ""
        self.signUpPasswordRepeat = ""
        self.favoriteCousine = 0
        self.dislikedFood = []
    }
    
    func toggleDislikedFood(ingredient: Ingredient) {
        if let index = dislikedFood.firstIndex(where: {
            $0.name == ingredient.name
        }){
            dislikedFood.remove(at: index)
            return
        }
        dislikedFood.append(ingredient)
    }
    
    func signIn() {
        print("Email is \(email) and password is \(password)")
        Auth.auth().signIn(withEmail: email, password: password, completion: {authResult, err in
            
            if err != nil {
                print("error")
                return
            }
            
            self.isLoggedIn = true
            
            print(String(self.isLoggedIn))
        })
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.isLoggedIn = false
        } catch let signoutError as NSError {
            print("Error while signing out")
            print(signoutError)
        }
    }
}
