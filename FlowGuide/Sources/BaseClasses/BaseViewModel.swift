//
//  BaseViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import FirebaseAuth

/// Base View Model
class BaseViewModel: NSObject {
    
    // MARK: - Properties

    let auth = Auth.auth()
    
    var isReachable: Bool {
        return Connectivity.isReachable
    }
}
