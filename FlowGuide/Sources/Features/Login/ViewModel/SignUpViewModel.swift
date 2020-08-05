//
//  SignUpViewModel.swift
//  FlowGuide
//
//  Created by TCS on 26/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import FirebaseAuth
import UtilitiesLib
import Combine

/// SignUp View Model
final class SignUpViewModel: AuthViewModel {
    
    func isValidPassword(_ password: String, _ confirmPassword: String) -> Bool {
        (password == confirmPassword) && password.count >= 6
    }
    
    /// SignUp New User
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    ///   - completion: Return failure/success
    func signUpNewUser(withEmail email: String,
                       password: String,
                       completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(Constants.AuthError.unknownError))
            }
        }
    }
}
