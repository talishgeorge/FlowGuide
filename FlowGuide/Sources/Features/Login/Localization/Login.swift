//
//  LoginLocalization.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

/// Login Localization
extension String {
    enum Login: String, Localizable {
        case forgetPassword
        case enterEmail
        case passwordReset
        case checkEmail
        case invalidForm
        case passwordIncorrect
        case login
        case signup
        case email
        case password
        case confirmPassword
        case loginError
        case loginErrorMessage
        var tableName: String {
            "Login"
        }
    }
}
