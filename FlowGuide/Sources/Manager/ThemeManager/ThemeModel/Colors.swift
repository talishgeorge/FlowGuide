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
    
    enum CodingKeys: String, CodingKey {
        
        case themeBlueTop
        case themeBottom
        case navigationTintHex
        case viewBorderColour
        case fontColorWhiteHex
    }
    
    init() {
        themeBlueTop = ""
        themeBottom = ""
        navigationTintHex = ""
        viewBorderColour = ""
        fontColorWhiteHex = ""
    }
    
}
