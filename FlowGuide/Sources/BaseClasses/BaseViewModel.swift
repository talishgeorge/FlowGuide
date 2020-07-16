//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import SBNLib

class BaseViewModel: NSObject {
    
    var isReachable: Bool {
            Connectivity.isReachable
       }
    
}
