//
//  LoginViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import FirebaseAuth

final class LoginViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    //private let auth = Auth.auth()
    var password: String?
    var email: String?
    
    var formIsValid: Bool {
        guard let email = email, !email.isEmpty,
            let password = password , !password.isEmpty else {
                return false
        }
        return true
    }
}

// MARK: - Internal Methds

extension LoginViewModel {
    
    func loginUser(withEmail email: String,
                   password: String,
                   completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(Constants.AuthError.unknownError))
            }
        }
    }
    
    func resetPassword(withEmail email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func logoutUser() -> Result<Void, Error> {
        do {
            try auth.signOut()
            return .success(())
        } catch let error {
            return .failure(error)
        }
    }
}

// MARK: - Static Methds

extension LoginViewModel {
    
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
