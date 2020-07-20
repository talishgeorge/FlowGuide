//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

protocol Themeable: class {
    func listenTheme()
    func didThemeChange()
}

extension Themeable where Self: UIViewController {
    func listenTheme() {
        _ = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: ThemeConstants.themeableNotificationName), object: nil, queue: nil) { [weak self] _ in
            self?.didThemeChange()
        }
    }
}

/// Theme properties
protocol ThemeStyle {
    var viewGradientTopColor: UIColor { get }
    var viewGradientBottomColor: UIColor {get}
    var navigationBarTintColor: UIColor {get}
    var borderColor: UIColor {get}
    var defaultFontColor: UIColor {get}
    func jsonForTheme(fileName: String)
    
}
