//
//  AccountViewModel.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import Foundation

final class AccountViewModel: ObservableObject {
    @Published var id: String
    @Published var image: String?
    @Published var name: String
    @Published var email: String
    
    private var authService: AuthService = .init()
    var router: AccountRouterInput!

    init(id: String = "", image: String? = nil, name: String = "", email: String = "") {
        self.id = id
        self.image = image
        self.name = name
        self.email = email
    }

    public static func == (lhs: AccountViewModel, rhs: AccountViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.name == rhs.name &&
            lhs.email == rhs.email
    }
}

extension AccountViewModel {
    func reloadDataSource() {
        let currentUser = SessionManager.shared.currentUser
        
        id = currentUser?.id ?? ""
        name = currentUser?.name ?? "NAME..."
        email = currentUser?.email ?? "EMAIL..."
    }
    
    func logOutButtonClicked() {
        authService.logout() 
        router.logOutButtonClicked()
    }
        
    
    func deleteAccoountButtonClicked() {
        authService.deleteUserAccount { isSuccess in
            self.router.deleteAccoountButtonClicked()
        }
    }
}
 
