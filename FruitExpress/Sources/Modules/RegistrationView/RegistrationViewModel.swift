//
//  RegistrationViewModel .swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

final class RegistrationViewModel: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var password: String
    
    @Published var showingAlert = false
    
    private var authService: AuthService = .init()
    var router: RegistrationRouterInput!

    init(name: String = "", email: String = "", password: String = "") {
        self.name = name
        self.email = email
        self.password = password
    }
}

extension RegistrationViewModel {
    func signUpButtonClicked() {
        Task {
            let isSuccess = try! await authService.register(email: email, password: password, name: name)
            
            if isSuccess && isFormValid {
                await MainActor.run {
                    print("isSuccess \(isSuccess)", isFormValid)
                    router.signUpButtonClicked()
                }
            } else {
                showingAlert = true
                print("isSuccess \(isSuccess)", isFormValid)
            }
        }
    }
    
    func haveAccountClicked() {
        router.haveAccountClicked()
    }
    
    func clearState() {
        name = ""
        email = ""
        password = ""
    }
}

extension RegistrationViewModel: AuthViewModelProtocol {
    var isFormValid: Bool {
        return email.isNotEmpty
        && email.contains("@")
        && password.isNotEmpty
        && password.count > 5
        && name.isNotEmpty
    }
}
