//
//  LetsCookApp.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI
import Firebase

@main
struct LetsCookApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
