//
//  LetsCookApp.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

//import SwiftUI
//import Firebase
//
//@main
//struct LetsCookApp: App {
//
//    init(){
//        FirebaseApp.configure()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
import SwiftUI
import Firebase
@main
struct LetsCookApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
        
    }
}
class Delegate : NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
        
    }
    
}
