//
//  SettingsView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: LoginViewModel
    @State var isYourRecipesActive: Bool = false
    @State var isYourUserActive: Bool = false
    
    var body: some View {
        VStack{
            Form {
                
                Section {
                    Button(action: {
                        isYourRecipesActive.toggle()
                        print("your recipes")
                    }) {
                        Text("Your recipes").foregroundColor(.black)
                        //                        .font(.title)
                    }
                }
                
                Section {
                    Button(action: {
                        isYourUserActive.toggle()
                        print("your user")
                    }) {
                        Text("Your user information")
                            .foregroundColor(.black)
                        //                        .font(.title)
                    }
                }
                
                Section{
                    Button(action: {
                        viewModel.signOut()
                    }){
                        Text("Log out").foregroundColor(.red)
                        //                        .font(.title)
                    }
                }
            }
            NavigationLink(destination: YourRecipesView(loginViewModel: viewModel), isActive: $isYourRecipesActive){
                EmptyView()
            }
            
            NavigationLink(destination: UserDetailsView(), isActive: $isYourUserActive){
                EmptyView()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: LoginViewModel())
    }
}
