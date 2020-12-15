//
//  CreateRecipeViewModel.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import Foundation
import FirebaseFirestore
import Firebase

final class CreateRecipeViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    
    @Published var currentProgress: Double = 0.0
    @Published var currentPage: Int = 0
    
    //FIRST PAGE
    @Published var recipeName: String = ""
    @Published var recipeDescription: String = ""
    @Published var recipeDifficulty: RecipeDifficulty?
    @Published var recipeCuisineType: Cuisine?
    @Published var recipeCookingDuration: String = ""
    
    //SECOND PAGE
    @Published var ingredients: [String] = []
    
    //THRID PAGE
    @Published var tutorial: String = ""
    
    @Published var imageName: String = ""
    
    func restartRecipe() {
        recipeName = ""
        recipeDescription = ""
        recipeCookingDuration = ""
        ingredients = []
        tutorial = ""
        imageName = ""
        recipeDifficulty = nil
        recipeCuisineType = nil
    }
    
    func createRecipe() {
        
        let recipe = Recipe(name: recipeName, image: imageName, description: recipeDescription, difficulty: recipeDifficulty ?? .easy, cookingDuration: recipeCookingDuration, ingredients: ingredients
                            , tutorial: tutorial, cuisineType: recipeCuisineType ?? Cuisine.european, createdBy: Auth.auth().currentUser?.email ?? "")
        do {
            try db.collection("recipes").document().setData(from: recipe)
        } catch let error {
            print("Error writing recipe to Firestore: \(error)")
        }
    }
    
    
    
    
    func updateRecipe() {
        let recipe = Recipe(name: recipeName, image: imageName, description: recipeDescription, difficulty: recipeDifficulty ?? .easy, cookingDuration: recipeCookingDuration, ingredients: ingredients
                            , tutorial: tutorial, cuisineType: recipeCuisineType ?? Cuisine.european, createdBy: Auth.auth().currentUser?.email ?? "")
        
        db.collection("recipes").whereField("image", isEqualTo: imageName)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            try self.db.collection("recipes").document(document.documentID).setData(from: recipe) { err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                }
                            }
                        } catch {
                            print("errr")
                        }
                    }
                }
            }
    }
}
