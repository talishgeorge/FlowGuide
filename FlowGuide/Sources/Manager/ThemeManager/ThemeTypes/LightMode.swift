//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UIKit
import UtilitiesLib

final class LightMode: ThemeStyle {
    
    var themeModel = AppThemeModel()
    
    var defaultFontColor: UIColor {
        UIColor.init(hexString: themeModel.colors?.fontColorWhiteHex
            ?? "", alpha: 1.0)
    }
    
    var viewGradientTopColor: UIColor {
        UIColor.init(hexString: themeModel.colors?.themeBlueTop ?? "", alpha: 1.0)
    }
    
    var viewGradientBottomColor: UIColor {
        UIColor.init(hexString: themeModel.colors?.themeBottom
            ?? "", alpha: 1.0)
    }
    
    var navigationBarTintColor: UIColor {
        UIColor.init(hexString: themeModel.colors?.navigationTintHex
            ?? "", alpha: 1.0)
    }
    
    var borderColor: UIColor {
        UIColor.init(hexString: themeModel.colors?.viewBorderColour
            ?? "", alpha: 1.0)
    }
    
    init() {
        self.jsonForTheme()
    }
}

// MARK: - Internal Method

internal extension LightMode {
    
    func jsonForTheme() {
        themeModel = ThemeManager.shared.loadTheme(fileName: ThemeConstants.lightMode)
    }
}
