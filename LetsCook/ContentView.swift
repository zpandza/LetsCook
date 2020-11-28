//
//  ContentView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    
    
    var body: some View {
        ZStack {
            if viewModel.isLoggedIn {
                HomeView(viewModel: viewModel)
            } else {
                if !viewModel.isSignUp {
                    LoginView(viewModel: viewModel)
                } else {
                    SignUpView(viewModel: viewModel)
                }
            }
        }
    }
}

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Color("AppBlue").edgesIgnoringSafeArea(.all)
        
        VStack {
            VStack{
                Spacer()
                Text("Let's cook!")
                    .foregroundColor(.white)
                    .font(.title)
                Image("logo")
                    .resizable()
                    .frame(width: screenWidth*0.3,
                           height: screenWidth*0.3)
                Spacer()
            }.frame(height: screenHeight*0.3)
            LoginFormContainerView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
