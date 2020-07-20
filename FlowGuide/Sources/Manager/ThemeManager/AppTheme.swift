//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UIKit
import UtilitiesLib

final class AppTheme: ThemeStyle {
    
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
    
    init(file: String) {
        self.jsonForTheme(fileName: file)
    }
}

// MARK: - Internal Method

internal extension AppTheme {
    
    func jsonForTheme(fileName: String) {
        themeModel = ThemeManager.shared.loadTheme(fileName: fileName)
    }
}
