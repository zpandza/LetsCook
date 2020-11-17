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
