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
        
        Text("Full Name")
            .font(.body)
            .fontWeight(.bold)
        
        TextField("Enter full name", text: $viewModel.signUpFullName)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
            .autocapitalization(.words)
            .padding(.bottom, 10)
        
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

    let data = [
        Cuisine.init(rawValue: 1),
        Cuisine.init(rawValue: 2),
        Cuisine.init(rawValue: 3),
        Cuisine.init(rawValue: 4),
        Cuisine.init(rawValue: 5),
        Cuisine.init(rawValue: 6),
        Cuisine.init(rawValue: 7),
        Cuisine.init(rawValue: 8),
    ]
    @State private var isClicked = false
    @State private var clickedCircleString: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10){
            Text("Select your favorite cousine")
                .font(.title)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                ForEach(data, id: \.self) { item in
                    VStack(alignment: .center, spacing: 5){
                        Image(item?.description.lowercased() ?? "")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle()
                                    .stroke(Color.black,
                                            lineWidth: 2))
                        Text(item?.description ?? "Default")
                    }
                        .brightness(self.isClicked && self.clickedCircleString == item!.description
                                        ? -0.5 : 0)
                    .onTapGesture {
                        if self.isClicked {
                            if self.clickedCircleString != item!.description{
                                self.clickedCircleString = item!.description
                                viewModel.favoriteCousine = item!.rawValue
                            } else {
                                self.clickedCircleString = ""
                                viewModel.favoriteCousine = 0
                                self.isClicked.toggle()
                            }
                        } else {
                            
                            self.clickedCircleString = item!.description
                            viewModel.favoriteCousine = item!.rawValue
                            self.isClicked.toggle()
                        }
                    }
                }
            }
        }
        
        
    }
}

struct SignUpFormT: View {
    
    @StateObject var viewModel: LoginViewModel
    @ObservedObject private var ingredientViewModel: IngredientViewModel = IngredientViewModel()
    @State var currentSearch: String = ""
    @State var filteredIngredients: [Ingredient] = IngredientViewModel().ingredientData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Disliked Food")
                .font(.title)
            TextField("Search", text: $ingredientViewModel.filterString)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10, style: .circular).foregroundColor(Color.gray.opacity(0.3)))
                .padding(.bottom, 10)
                .onChange(of: ingredientViewModel.filterString, perform: { value in
                    ingredientViewModel.filterList()
                })
            
            List {
                ForEach(ingredientViewModel.ingredientData){ ingredient in
                    HStack {
                        Text(ingredient.name)
                            .font(.headline)
                        Spacer()
                        Image(systemName: viewModel.isFoodDisliked(ingredient: ingredient) ? "checkmark" : "")
                    }.onTapGesture {
                        viewModel.toggleDislikedFood(ingredient: ingredient)
                        print(ingredient.name)
                    }
                }
            }
        }
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
                        viewModel.resetValues()
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
                        viewModel.signUp()
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
