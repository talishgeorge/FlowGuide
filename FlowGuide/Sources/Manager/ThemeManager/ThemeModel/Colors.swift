//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

struct Colors: Decodable {
    
    let themeBlueTop: String?
    let themeBottom: String?
    let navigationTintHex: String?
    let viewBorderColour: String?
    let fontColorWhiteHex: String?
    
    init() {
        themeBlueTop = ""
        themeBottom = ""
        navigationTintHex = ""
        viewBorderColour = ""
        fontColorWhiteHex = ""
    }
    
}
