//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import UIKit
import UtilitiesLib

final class DarkMode: ThemeStyle {
    
    var themeModel = AppThemeModel()
    
    var defaultFontColor: UIColor {
        let hexString = themeModel.colors?.fontColorWhiteHex
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
        
    }
    
    var viewGradientTopColor: UIColor {
        let hexString = themeModel.colors?.themeBlueTop ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    var viewGradientBottomColor: UIColor {
        let hexString = themeModel.colors?.themeBottom
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    var navigationBarTintColor: UIColor {
        let hexString = themeModel.colors?.navigationTintHex
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    var borderColor: UIColor {
        let hexString = themeModel.colors?.viewBorderColour
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    init() {
        self.jsonForTheme()
    }
}

// MARK: - Internal Method

internal extension DarkMode {
    func jsonForTheme() {
        themeModel = CustomThemeManger.shared.loadTheme(fileName: "DarkMode")
    }
}
