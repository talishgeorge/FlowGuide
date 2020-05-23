//
//  AuthManager.swift
//  FlowGuide
//
//  Created by Talish George on 23/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import FirebaseAuth

struct AuthManager {
    
    let auth = Auth.auth()
    enum AuthError: Error {
        case unknownError
    }
    
    func signUpNewUser(withEmail email: String,
                       password: String,
                       completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknownError))
            }
        }
    }
    
    func loginUser(withEmail email: String,
                       password: String,
                       completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknownError))
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
