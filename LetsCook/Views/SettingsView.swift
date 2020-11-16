//
//  SettingsView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 16.11.2020..
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            viewModel.signOut()
        }){
            Text("Log out")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: LoginViewModel())
    }
}
