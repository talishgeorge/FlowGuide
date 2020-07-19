//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

struct AppThemeModel: Decodable {
    
    let colors: Colors?
    let font: Font?
    init() {
        font = Font()
        colors = Colors()
    }
}
