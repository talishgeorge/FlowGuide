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
    
    var isReachable: Bool {
        return Connectivity.isReachable
    }
}
