//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UtilitiesLib
import UIKit

class CustomThemeManger {
    
    var theme: ThemeStyle?
    
    static var shared: CustomThemeManger = {
        let themeneManager  = CustomThemeManger()
        return themeneManager
        
    }()
    
    func setTheme(theme: ThemeStyle) {
        self.theme = theme
    }
    
}
