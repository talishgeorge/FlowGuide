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
        case forget_password = "forget_password"
        case enter_email = "enter_email"
        case passwordReset = "password_reset"
        case check_email = "tcheck_email"
        case invalid_form = "invalid_form"
        case password_incorrect = "password_incorrect"
        case login = "login"
        case signup = "signup"
        case email = "email"
        case password = "password"
        case confirm_password = "confirm_password"
        case loginError = "Something went wrong"
        case loginErrorMessage = "Do you want to continue without SignIn"
        var tableName: String {
            return "Login"
        }
    }
}
