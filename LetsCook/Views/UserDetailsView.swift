//
//  UserDetailsView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 14.12.2020..
//

import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var updateUserViewModel: UpdateUserViewModel = UpdateUserViewModel()
    
    @State private var isEdit: Bool = false
    @State private var selectedCuisineIndex = 0
    
    let cuisines = ["Asian", "BBQ", "Italian", "American", "Balkan", "Chinese", "Indian", "European"]
    
    var navigationButton: String {
        if isEdit {
            return "View"
        } else {
            return "Edit"
        }
    }
    
    
    var body: some View {
        VStack {
            if isEdit {
                Form {
                    Section(header: Text("Full name")){
                        TextField("Full name", text: $updateUserViewModel.fullName)
                    }
                    
                    Section(header: Text("Cuisine")){
                        Picker(selection: $selectedCuisineIndex, label: Text("")){
                            ForEach(0 ..< cuisines.count) {
                                Text(cuisines[$0])
                            }
                        }
                    }
                }
            } else {
                Text("Name: ")
                    .font(.title2)
                    .padding()
                
                Text("Email: ")
                    .font(.title2)
                    .padding()
                
                Text("Favorite Cuisine: ")
                    .font(.title2)
                    .padding()
                
                Text("Disliked Food: ")
                    .font(.title2)
                    .padding()
                
                
            }
        }.navigationBarItems(trailing: Button(action: {isEdit.toggle()}){Text(navigationButton)})
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
