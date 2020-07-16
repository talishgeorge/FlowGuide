//
//  BaseViewModel.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import FirebaseAuth

/// Auth View Model
class AuthViewModel: BaseViewModel {
    
    let auth = Auth.auth()
    var password: String?
    var email: String?
    var confirmPassword: String?

    /// Init
    /// - Parameters:
    ///   - email: Email for signup and login
    ///   - password: Password to login
    ///   - confirmPassword: Password for signup
    init(_ email: String? = nil, _ password: String? = nil, _ confirmPassword: String? = nil) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
