//
//  LoginViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import FirebaseAuth

/// Login ViewModel
final class LoginViewModel: BaseViewModel {
    
    // MARK: - Properties
  
    var formIsValid: Bool {
        guard let email = email, !email.isEmpty,
            let password = password, !password.isEmpty else {
                return false
        }
        return true
    }
}

// MARK: - Internal Methds

extension LoginViewModel {
    
    /// Login User
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    ///   - completion: return type failure/success
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
    
    /// Reset Password
    /// - Parameters:
    ///   - email: String
    ///   - completion: return type failure/success
    func resetPassword(withEmail email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    /// Logout User
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
    
    /// Return current logined User
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
