//
//  SignUpView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 17.11.2020..
//

import SwiftUI

struct SignUpView: View {
    
    @State private var validationState: SignUpFormF.ValidationState? = nil
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        
        let validation = SignUpValidation(viewModel: viewModel, validationState: $validationState)
        
        VStack {
            ProgressView("Progress...", value: viewModel.currentProgress, total: 100)
                .padding()
            
            VStack(alignment: .leading, spacing: 10){
                if viewModel.currentPage == 0 {
                    SignUpFormF(viewModel: viewModel, validation: validation)
                } else if viewModel.currentPage == 1{
                    SignUpFormS(viewModel: viewModel)
                } else if viewModel.currentPage == 2{
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
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.green).opacity(0.7))
                    })
                }
            }.padding()
            
            Spacer()
            Button(action: {
                viewModel.isSignUp.toggle()
                viewModel.resetValues()
                viewModel.currentPage = 0
            }, label: {
                Text("You already have account?")
            })
        }.alert(item: $validationState) { state in
            Alert(title: Text(state.errorMessage ?? ""),
                  message: Text(state.errorDescription ?? ""))
        }
    }
}

struct SignUpFormF: View {
    @StateObject var viewModel: LoginViewModel

    struct ValidationState: Identifiable {
        let id = UUID()
        var errorMessage: String? = nil
        var errorDescription: String? = nil
    }
    var validation: SignUpValidation
    
    var body: some View {
        
        Text("Full Name")
            .font(.body)
            .fontWeight(.bold)
        
        TextField("Enter full name", text: $viewModel.signUpFullName)
            .textFieldStyle(TextFieldInvalid(isValid: validation.fullNameValid()))
        
        Text("Email")
            .font(.body)
            .fontWeight(.bold)
        
        TextField("Enter email", text: $viewModel.signUpEmail)
            .textFieldStyle(TextFieldInvalid(isValid: validation.emailValid()))
        
        Text("Password")
            .font(.body)
            .fontWeight(.bold)
        
        SecureField("Enter password", text: $viewModel.signUpPassword)
            .textFieldStyle(TextFieldInvalid(isValid: validation.passwordValid()))
        
        Text("Repeat Password")
            .font(.body)
            .fontWeight(.bold)
        
        SecureField("Re-enter password", text: $viewModel.signUpPasswordRepeat)
            .textFieldStyle(TextFieldInvalid(isValid: viewModel.signUpPassword == viewModel.signUpPasswordRepeat))
        HStack(){
            Spacer()
            Text("Password must containt at least 8 characters!")
                .font(.caption)
                .foregroundColor(Color.gray)
        }
        Button(action: {
            if validation.firstFormValid() {
                viewModel.currentPage += 1
                viewModel.currentProgress = 33.33
            } else {
                print("form is invalid")
            }
        }) {
            Text("Proceed")
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.green).opacity(0.7))
        }.disabled(validation.firstPageEmpty())
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
            Button(action: {
                viewModel.currentPage += 1
                viewModel.currentProgress = 66.67
            }) {
                Text("Proceed")
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.green).opacity(0.7))
            }
        }
        
        
    }
}

struct SignUpFormT: View {
    
    @StateObject var viewModel: LoginViewModel
    @ObservedObject private var ingredientViewModel: IngredientViewModel = IngredientViewModel()
    @State var currentSearch: String = ""
    @State var filteredIngredients: [String] = IngredientViewModel().ingredientData
    
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
                ForEach(ingredientViewModel.ingredientData, id: \.self){ ingredient in
                    HStack {
                        Text(ingredient)
                            .font(.headline)
                        Spacer()
                        Image(systemName: viewModel.isFoodDisliked(ingredient: ingredient) ? "checkmark" : "")
                    }.onTapGesture {
                        viewModel.toggleDislikedFood(ingredient: ingredient)
                        print(ingredient)
                    }
                }
            }
            Button(action: {
                viewModel.currentPage += 1
                viewModel.currentProgress = 100.0
                viewModel.signUp()
            }) {
                Text("Proceed")
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.green).opacity(0.7))
            }
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: LoginViewModel())
    }
}
