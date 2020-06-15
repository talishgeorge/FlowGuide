//
//  Connectivity.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Alamofire

final class Connectivity {
    static var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
