//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

/// Theme properties
protocol ThemeStyle {
    
    var viewGradientTopColor: UIColor { get }
    var viewGradientBottomColor: UIColor {get}
    var navigationBarTintColor: UIColor {get}
    var borderColor: UIColor {get}
    var defaultFontColor: UIColor {get}
    var cellBgColor: UIColor {get}
    var cellSeperatorBgColor: UIColor {get}
    var tabBarBgColor: UIColor {get}
    var headerCellBgColor: UIColor {get}
    var fontWhiteColor: UIColor {get}
    func jsonForTheme(fileName: String)
    
}
