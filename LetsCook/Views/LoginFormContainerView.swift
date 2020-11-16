//
//  LoginFormContainerView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI

struct LoginFormContainerView: View {
    
    @ObservedObject var viewModel: LoginViewModel

    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white).cornerRadius(25)
            
            VStack (alignment: .leading, spacing: 10){
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("Continue after logging in")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer().frame(height: 18)
                
                Text("Email")
                    .font(.body)
                    .fontWeight(.bold)
                
                TextField("Enter email", text: $viewModel.email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                
                Text("Password")
                    .font(.body)
                    .fontWeight(.bold)
                
                SecureField("Enter email", text: $viewModel.password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
                
                Spacer().frame(height: 16)
                
                Button(action: {
                    self.viewModel.signIn()
                }) {
                    HStack {
                        Spacer()
                        Text("Login").font(.title).foregroundColor(.white)
                        Spacer()
                    }.padding()
                    .background(Color.pink)
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .frame(minWidth: 0,
                   maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .topLeading)
            .padding()
            
            
        }
    }
}

struct LoginFormContainerView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormContainerView(viewModel: LoginViewModel())
    }
}
