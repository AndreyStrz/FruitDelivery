//
//  AuthorizationViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

final class AuthorizationViewModel: ObservableObject {
    @Published var email: String
    @Published var password: String
    
    @Published var showingAlert = false
    
    private var authService: AuthService = .init()
    var router: AuthorizationRouterInput!
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    public static func == (lhs: AuthorizationViewModel, rhs: AuthorizationViewModel) -> Bool {
        return lhs.email == rhs.email &&
            lhs.password == rhs.password
    }
}

extension AuthorizationViewModel {
    func signInButtonClicked() {
        Task {
            let isSuccess = try await authService.login(email: email, password: password)
            
            if isSuccess && isFormValid {
                await MainActor.run {
                    router.signInButtonClicked()
                }
            } else {
                showingAlert = true
                print("Invalid log or password")
            }
        }
        
    }
    
    func clearState() {
        email = ""
        password = ""
    }
    
    func haveNotAccountClicked() {
        router.haveNotAccountClicked()
    }
    
    func anonymousLoginButtonClicked() {
        router.anonymousLoginButtonClicked()
    }
}

extension AuthorizationViewModel: AuthViewModelProtocol {
    var isFormValid: Bool {
        return email.isNotEmpty
        && email.contains("@")
        && password.isNotEmpty
        && password.count > 5
    }
}
