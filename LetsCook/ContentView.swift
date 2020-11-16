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
//            NavigationLink(destination: Text("Logged in!"), isActive: $viewModel.isLoggedIn){
//                EmptyView()
//            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
