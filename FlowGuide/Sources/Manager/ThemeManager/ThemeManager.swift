//
//  ThemeManager.swift
//  FlowGuide
//
//  Created by TCS on 26/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import UIKit

/// Theme Manger Class
final class ThemeManager {
    
    /// Initial NavigationBar setup
    static func setup() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 47/255, green: 54/255, blue: 64/255, alpha: 1.0)
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.navigationAttributes]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key: Any], for: .normal)
    }
}
