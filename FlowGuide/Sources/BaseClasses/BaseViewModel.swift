//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation

class BaseViewModel: NSObject {
    
    var isReachable: Bool {
        Reachability.isConnectedToNetwork()
    }
}
