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
    let fontColor: String?
    let headerCellBgColor: String?
    let cellBgColor: String?
    let tabBarBgColor: String?
    let cellSeperatorBgColor: String?
    let fontWhiteColor: String?
    let viewDarkColor: String?
    let switchOnTint: String?

    init() {
        themeBlueTop = ""
        themeBottom = ""
        navigationTintHex = ""
        viewBorderColour = ""
        fontColor = ""
        headerCellBgColor = ""
        cellBgColor = ""
        tabBarBgColor = ""
        cellSeperatorBgColor = ""
        fontWhiteColor = ""
        viewDarkColor = ""
        switchOnTint = ""
    }
}
