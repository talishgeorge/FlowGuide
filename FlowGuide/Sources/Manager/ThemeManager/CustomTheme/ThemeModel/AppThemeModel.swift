//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

struct AppThemeModel: Decodable {
    
    let colors: Colors?
    let font: Font?
    
    enum CodingKeys: String, CodingKey {
        case colors
        case font
    }
    init() {
        font = Font()
        colors = Colors()
    }
}
