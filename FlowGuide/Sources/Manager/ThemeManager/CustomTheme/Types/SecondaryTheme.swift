//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import UIKit
import UtilitiesLib

public class SecondaryTheme: ThemeStyle {
    
    var themeModel = AppThemeModel()
    
    var defaultFontColor: UIColor {
        return fontColorWhite()
    }
    
    var viewGradientTopColor: UIColor {
        return gradientTopColor()
    }
    
    var viewGradientBottomColor: UIColor {
        return gradientBottomColor()
    }
    
    var navigationBarTintColor: UIColor {
        return navigationTintColor()
    }
    
    var borderColor: UIColor {
        return viewBorderColor()
    }
    
    init() {
        self.jsonForTheme()
    }
    
    func jsonForTheme() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "SecondaryTheme",
                                                 ofType: ApiConstants.decodingType),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(AppThemeModel.self, from: jsonData)
                    themeModel = responseModel
                    
                } catch _ {
                    
                }
            }
        } catch {
        }
        
    }
    
}

extension SecondaryTheme {
    
    func fontColorWhite() -> UIColor {
        let hexString = themeModel.colors?.fontColorWhiteHex
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
        
    }
    
    func navigationTintColor() -> UIColor {
        let hexString = themeModel.colors?.navigationTintHex
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    func gradientTopColor() -> UIColor {
        let hexString = themeModel.colors?.themeBlueTop ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    func gradientBottomColor() -> UIColor {
        let hexString = themeModel.colors?.themeBottom
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    func viewBorderColor() -> UIColor {
        let hexString = themeModel.colors?.viewBorderColour
            ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
}
