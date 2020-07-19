//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

protocol ThemeStyle {
    
    var viewGradientTopColor: UIColor { get }
    var viewGradientBottomColor: UIColor {get}
    var navigationBarTintColor: UIColor {get}
    var borderColor: UIColor {get}
    var defaultFontColor: UIColor {get}
    func jsonForTheme()
}
