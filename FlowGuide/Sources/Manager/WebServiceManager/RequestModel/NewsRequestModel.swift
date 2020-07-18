//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import NetWorkLib

/// API Request Model 
final class NewsRequestModel: RequestModel {
    override var path: String {
        return ServiceConstant.news
    }
}
