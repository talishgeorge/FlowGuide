//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import NetWorkLib

class BaseViewModel: NSObject {
    static public let shared = BaseViewModel()
    let webService = WebService()
    var isReachable: Bool {
        Reachability.isConnectedToNetwork()
        
    }
}
