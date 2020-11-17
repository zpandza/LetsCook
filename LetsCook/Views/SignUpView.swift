//
//  SignUpView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import SwiftUI

struct SignUpFormF: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        Text("Email")
            .font(.body)
            .fontWeight(.bold)
        
        TextField("Enter email", text: $viewModel.signUpEmail)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .padding(.bottom, 10)
        
        Text("Password")
            .font(.body)
            .fontWeight(.bold)
        
        SecureField("Enter password", text: $viewModel.signUpPassword)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
            .padding(.bottom, 10)
        
        Text("Repeat Password")
            .font(.body)
            .fontWeight(.bold)
        
        SecureField("Re-enter password", text: $viewModel.signUpPasswordRepeat)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
        HStack(){
            Spacer()
            Text("Password must containt at least 8 characters!")
                .font(.caption)
                .foregroundColor(Color.gray)
        }
    }
}

struct SignUpFormS: View {
    
    @StateObject var viewModel: LoginViewModel

    
    var body: some View {
        Text("Second part")
    }
}

struct SignUpFormT: View {
    
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        Text("Third part")
    }
}

struct SignUpView: View {
    
    @StateObject var viewModel: LoginViewModel

    @State private var progress = 0.0
    @State private var page: Int = 0
    
    var body: some View {
        VStack {
            ProgressView("Progress...", value: progress, total: 100)
                .padding()
            
            VStack(alignment: .leading, spacing: 10){
                if page == 0 {
                    SignUpFormF(viewModel: viewModel)
                } else if page == 1{
                    SignUpFormS(viewModel: viewModel)
                } else if page == 2{
                    SignUpFormT(viewModel: viewModel)
                } else {
                    Text("Congratulations! You successfully registered!!")
                    
                    Text("We sent you verification link to your email. Please verify yourself and then Login to our app!")
                    
                    Text("Thank you for your trust.")
                    
                    Button(action: {
                        viewModel.isSignUp.toggle()
                    }, label: {
                        Text("Back to Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                    })
                }
            }.padding()
            
            if(page < 3){
                Button(action: {
                    page += 1
                    if(page == 3){
                        progress = 100.0
                    } else {
                        progress = Double(page * 100/3)
                    }
                }, label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                })
            }
            
            Spacer()
            Button(action: {
                viewModel.isSignUp.toggle()
            }, label: {
                Text("You already have account?")
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: LoginViewModel())
    }
}
