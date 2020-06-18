//
//  BaseViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import FirebaseAuth

class BaseViewModel: NSObject {
    
    let auth = Auth.auth()
    var password: String?
    var email: String?
    var confirmPassword: String?
    var isReachable: Bool {
        return Connectivity.isReachable
    }
    
    init(_ email: String? = nil, _ password: String? = nil, _ confirmPassword: String? = nil) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
