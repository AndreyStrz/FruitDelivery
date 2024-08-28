//
//  RegistrationScreen.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI

struct RegistrationScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 20) {
            MainTextField(text: $viewModel.name, placeholder: "NAME...")
            MainTextField(text: $viewModel.email, placeholder: "EMAIL...")
                .keyboardType(.emailAddress)
            SecureTextField(text: $viewModel.password, placeholder: "PASSWORD...")
            
            MainButton(text: "SIGN UP", fontPalette: .sign, layout: .sign) {
                viewModel.signUpButtonClicked()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("SOMETHING WENT WRONG."), message: Text("REGISTRATION ERROR. PLEASE MAKE SURE YOUR PASSWORD IS AT LEAST 6 CHARACTERS LONG AND YOUR EMAIL CONTAINS @."), dismissButton: .default(Text("OK")))
            }
            .padding(.top, 8)
            Spacer()
            Button("DO YOU ALREADY HAVE AN ACCOUNT? \n SIGN IN") {
                viewModel.haveAccountClicked()
            }
            .foregroundColor(.white)
            .padding(.bottom, 48)
        }
        .padding(.top, 200)
        .padding(.horizontal, 36)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
        .onDisappear {
            viewModel.clearState()
        }
    }
}

//extension RegistrationScreen: AuthViewModelProtocol {
//    var isFormValid: Bool {
//        return viewModel.email.isNotEmpty
//        && viewModel.email.contains("@")
//        && viewModel.password.isNotEmpty
//        && viewModel.password.count > 5
//        && viewModel.name.isNotEmpty
//        
//    }
//}

#Preview {
    RegistrationScreen(viewModel: .init(name: "", email: "", password: ""))
}
