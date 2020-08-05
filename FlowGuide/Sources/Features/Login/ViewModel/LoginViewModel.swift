//
//  LoginViewModel.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import FirebaseAuth
import UtilitiesLib

/// Login ViewModel
final class LoginViewModel: AuthViewModel {
    
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
    
    /// Reset Password with Email as Input
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
}
