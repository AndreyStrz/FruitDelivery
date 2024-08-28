//
//  AuthService.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 22.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


final class AuthService: ObservableObject {
    func register(email: String, password: String, name: String) async throws -> Bool {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = UserModel(id: result.user.uid, email: email, name: name)
            let encodedUser = try Firestore.Encoder().encode(user)
            
            Task {
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            }
           
            // Проверка записи
            print("MDM - User saved: \(user)")
            return true
        } catch {
            print(error)
            print("Auth failed")
            return false
        }
    }
    
    func login(email: String, password: String) async throws -> Bool {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            print("MDM - Singed IN")
            return true
        } catch {
            print("Error login: \(error.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            print("MDM - LOUGOUTED")
            return true
        } catch {
            print("Error signout: \(error.localizedDescription)")
            return false
        }
    }

    func deleteUserAccount(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("MDM - user is nil", #function)
            return completion(false)
        }
        
        user.delete { error in
            completion(error.isNil)
        }
    }


    
    func fetchUser() async -> UserModel? {
       guard let uid = Auth.auth().currentUser?.uid else { return nil }
    
       do {
           let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
           return try snapshot.data(as: UserModel.self)
       } catch {
           print("Error fetching user: \(error.localizedDescription)")
           return nil
       }
   }
}
