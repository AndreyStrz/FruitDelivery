//
//  AuthorizationView.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import SwiftUI

struct AuthorizationView: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: AuthorizationViewModel
    
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var showingAlert = false
    

    var body: some View {
            VStack(spacing: 20) {
                MainTextField(text: $viewModel.email, placeholder: "EMAIL...")
                    .keyboardType(.emailAddress)
                SecureTextField(text: $viewModel.password, placeholder: "PASSWORD...")
                
                MainButton(text: "SIGN IN", fontPalette: .sign, layout: .sign) {
                    viewModel.signInButtonClicked()
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("SOMETHING WENT WRONG."), message: Text("AUTHENTICATION ERROR. PLEASE CHECK YOUR CREDENTIALS AND TRY AGAIN."), dismissButton: .default(Text("OK")))
                }
                .padding(.top, 8)
                Button("ANONYMUS LOGIN") {
                    viewModel.anonymousLoginButtonClicked()
                }
                .foregroundColor(.white)
                Spacer()
                Button("YOU DON'T HAVE AN ACCOUNT YET? \n SIGN UP NOW?") {
                    viewModel.haveNotAccountClicked()
                }
                .foregroundColor(.white)
                .padding(.bottom, 48)
            }
            .padding(.top, 280)
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

#Preview {
    AuthorizationView(viewModel: .init(email: "123", password: "123") )
}
