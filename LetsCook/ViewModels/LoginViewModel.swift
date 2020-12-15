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
    
    let db = Firestore.firestore()
    let recipeViewModel = RecipeViewModel()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isSignUp: Bool = false
    
    //SIGNUP STATES
    @Published var signUpFullName: String = ""
    @Published var signUpEmail: String = ""
    @Published var signUpPassword: String = ""
    @Published var signUpPasswordRepeat = ""
    @Published var favoriteCousine: Int = 0
    @Published var dislikedFood: [String] = []
    
    
    @Published var currentPage: Int = 0
    @Published var currentProgress: Double = 0.0
    
    @Published var favoriteRecipes: [Recipe] = []
    @Published var usersRecipes: [Recipe] = []
    
    let currentUserMail = Auth.auth().currentUser?.email ?? "dummy@g.rit.edu"
    
    
    init(){
        isLoggedIn = Auth.auth().currentUser != nil ? true : false
        if isLoggedIn {
            getFavoriteRecipes()
        }
    }
    
    func deleteRecipe(recipe: Recipe) {
        db.collection("recipes").whereField("image", isEqualTo: recipe.image)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.db.collection("recipes").document(document.documentID).delete() { err in
                            if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                }
                        }
                    }
                }
                
                
                //        db.collection("recipes").document().delete() { err in
                //            if let err = err {
                //                print("Error removing document: \(err)")
                //            } else {
                //                print("Document successfully removed!")
                //            }
                //        }
                
            }
    }
        
        func getUsersRecipes() {
            print(recipeViewModel.recipeData)
            
            
            //        for recipe in recipeViewModel.recipeData {
            //            if recipe.createdBy == currentUserMail {
            //
            //            }
            //        }
            db.collection("recipes").whereField("createdBy", isEqualTo: currentUserMail)
                .addSnapshotListener { querrySnapshot, err in
                    guard let documents = querrySnapshot?.documents else {
                        print("Error fetching documents: \(err!)")
                        return
                    }
                    print(self.usersRecipes)
                    if self.usersRecipes.count > 0 {
                        self.usersRecipes = []
                    }
                    documents.forEach { (snapshot) in
                        let data = snapshot.data()
                        
                        let cookingDuration_ = data["cookingDuration"] as? String ?? ""
                        let createdBy_ = data["createdBy"] as? String ?? ""
                        let cuisineType_ = data["cuisineType"] as? Int ?? 1
                        let description_ = data["description"] as? String ?? ""
                        let difficulty_ = data["difficulty"] as? Int ?? 1
                        let id_ = data["id"] as? UUID ?? UUID()
                        let image_ = data["image"] as? String ?? ""
                        let ingredients_ = data["ingredients"] as? [String] ?? []
                        let name_ = data["name"] as? String ?? ""
                        let tutorial_ = data["tutorial"] as? String ?? ""
                        
                        let recipe = Recipe(id: id_, name: name_, image: image_, description: description_, difficulty: RecipeDifficulty(rawValue: difficulty_) ?? RecipeDifficulty.easy, cookingDuration: cookingDuration_, ingredients: ingredients_, tutorial: tutorial_, cuisineType: Cuisine(rawValue: cuisineType_) ?? Cuisine.american, createdBy: createdBy_)
                        
                        self.usersRecipes.append(recipe)
                        
                    }
                }
        }
        
        func getFavoriteRecipes(){
            
            db.collection("users").whereField("email", isEqualTo: currentUserMail)
                .addSnapshotListener { querrySnapshot, err in
                    guard let documents = querrySnapshot?.documents else {
                        print("Error fetching documents: \(err!)")
                        return
                    }
                    documents.forEach { (snapshot) in
                        let data = snapshot.data()
                        if self.favoriteRecipes.count > 0 {
                            self.favoriteRecipes = []
                        }
                        for recipe in data {
                            if recipe.key == "favorites" {
                                do {
                                    print(self.favoriteRecipes)
                                    let jsonData = try JSONSerialization.data(withJSONObject: recipe.value, options: [])
                                    let recipeObject = try JSONDecoder().decode([Recipe].self, from: jsonData)
                                    self.favoriteRecipes.append(contentsOf: recipeObject)
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                }
        }
        
        func toggleFavoriteFood(recipe: Recipe) {
            
            
            db.collection("users").whereField("email", isEqualTo: currentUserMail)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print(document.documentID)
                            let fullName_ = document.data()["fullName"] as? String ?? ""
                            let email_ = document.data()["email"] as? String ?? ""
                            let password_ = document.data()["password"] as? String ?? ""
                            let createdTime_ = document.data()["createdTime"] as? Timestamp ?? Timestamp()
                            let favoriteCuisine_ = document.data()["favoriteCuisine"] as? Int ?? 1
                            let dislikedFood_ = document.data()["dislikedFood"] ?? []
                            
                            var alreadyExists: Bool = false
                            
                            self.favoriteRecipes.forEach { r in
                                if r.name == recipe.name && r.image == recipe.image{
                                    alreadyExists = true
                                }
                            }
                            print(self.favoriteRecipes)
                            
                            var tempList = self.favoriteRecipes
                            
                            if !alreadyExists {
                                tempList.append(recipe)
                                print(self.favoriteRecipes)
                            } else {
                                let index = self.favoriteRecipes.firstIndex { (r) -> Bool in
                                    recipe.name == r.name && recipe.image == r.image
                                }
                                tempList.remove(at: index!)
                                
                            }
                            var favList = [Any]()
                            print(tempList)
                            
                            tempList.forEach { favoriteRecipe in
                                do {
                                    let jsonData = try JSONEncoder().encode(favoriteRecipe)
                                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                    favList.append(jsonObject)
                                } catch {
                                    print("Something went wrong while encoding/decoding")
                                }
                            }
                            
                            print(favList)
                            
                            self.db.collection("users")
                                .document("\(document.documentID)")
                                .setData([
                                    "fullName": fullName_,
                                    "email": email_,
                                    "password": password_,
                                    "createdTime": createdTime_,
                                    "favoriteCuisine": favoriteCuisine_,
                                    "dislikedFood": dislikedFood_,
                                    "favorites": favList
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                        }
                    }
                }
        }
        
        func isFoodDisliked(ingredient: String) -> Bool {
            if dislikedFood.contains(where: {
                print($0)
                print(ingredient)
                return $0 == ingredient
            }){
                return true
            }
            return false;
        }
        
        func resetValues(){
            self.signUpFullName = ""
            self.signUpEmail = ""
            self.signUpPassword = ""
            self.signUpPasswordRepeat = ""
            self.favoriteCousine = 0
            self.dislikedFood = []
        }
        
        func toggleDislikedFood(ingredient: String) {
            if let index = dislikedFood.firstIndex(where: {
                $0 == ingredient
            }){
                dislikedFood.remove(at: index)
                return
            }
            dislikedFood.append(ingredient)
        }
        
        func validateSignup() -> Bool {
            //VALIDATION GOES HERE
            return true
        }
        
        func signUp() {
            if validateSignup() {
                Auth.auth().createUser(withEmail: self.signUpEmail, password: self.signUpPassword, completion: { authResult, err in
                    guard let user = authResult?.user, err == nil else {
                        print("Error occured: \(err!.localizedDescription)")
                        return
                    }
                    
                    let createdUser = User(fullName: self.signUpFullName, email: self.signUpEmail.lowercased(), password: self.signUpPassword,
                                           favoriteCuisine: Cuisine(rawValue: self.favoriteCousine)!, dislikedFood: self.dislikedFood, favorites: [])
                    do {
                        let _ = try self.db.collection("users").addDocument(from: createdUser)
                    } catch {
                        print("error")
                    }
                    print("User created with email: \(String(describing: user.email))")
                })
                
            } else {
                print("Form is not valid")
            }
            
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

