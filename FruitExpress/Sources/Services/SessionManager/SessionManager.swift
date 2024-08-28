//
//  SessionManager.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 22.08.2024.
//

import FirebaseAuth

final class SessionManager {
    static var shared: SessionManager = .init()
    
    @Published var userSession: FirebaseAuth.User?
    var currentUser: UserModel?
    
    var isLoggedIn: Bool {
        return userSession != nil
    }
    
    var subscritpions: [any NSObjectProtocol] = []
    
    
    // MARK: Services
    private let authService: AuthService = .init()
    
    private init() {
        subscritpions.append(
            Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                guard let self else { return }
                
                self.userSession = user
                
                Task { @MainActor in
                    if user.isNotNil {
                        self.currentUser = await self.authService.fetchUser()
                    } else {
                        self.currentUser = nil
                    }
                    
                    print("MDM - upd USER \(user.isNotNil)")
                }
            }
        )
    }
}
