//
//  LoadingViewModel.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

final class LoadingViewModel: BaseViewModel {
    
    /// Return Current User
    static func isUserLoggedIn() -> Bool {
        return LoginViewModel.isUserLoggedIn()
    }
}
