//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UtilitiesLib
import UIKit

class CustomThemeManger {
    
    var theme: ThemeStyle?
    
    static var shared = CustomThemeManger()
    
    func setTheme(theme: ThemeStyle) {
        self.theme = theme
    }
}

// MARK: - Public Method

extension CustomThemeManger {
    
    func loadTheme(fileName: String) -> AppThemeModel {
        var themeModel = AppThemeModel()
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName,
                                                 ofType: ApiConstants.decodingType),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(AppThemeModel.self, from: jsonData)
                    themeModel = responseModel
                    
                } catch _ { print("Theme Decode Error!") }
            }
        } catch { print("Theme JSON file Error!") }
        return themeModel
    }
}
