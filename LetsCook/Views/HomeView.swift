//
//  HomeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI



struct HomeView: View {
    
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        Button(action: {
            viewModel.signOut()
        }){
            Text("Log out")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: LoginViewModel())
    }
}
