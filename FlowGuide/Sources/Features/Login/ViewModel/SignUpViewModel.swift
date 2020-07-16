//
//  SignUpViewModel.swift
//  FlowGuide
//
//  Created by TCS on 26/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import FirebaseAuth
import UtilitiesLib

/// SignUp View Model
final class SignUpViewModel: AuthViewModel {
    /// Validate Email and Password from form.
    var formIsValid: Bool {
        guard let email = email, !email.isEmpty,
            let password = password, !password.isEmpty,
            let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
                return false
        }
        return true
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
