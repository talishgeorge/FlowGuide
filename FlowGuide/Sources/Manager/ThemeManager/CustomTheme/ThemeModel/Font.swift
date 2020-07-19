//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

struct Font: Decodable {
    let avenirNextCondensed: String?
    
    enum CodingKeys: String, CodingKey {
        
        case avenirNextCondensed
    }
    
    init() {
        avenirNextCondensed = ""
    }
    
}
