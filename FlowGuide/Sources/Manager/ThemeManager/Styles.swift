//
//  Styles.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

/// Configure Theme
struct Theme {

    static var backgroundColor: UIColor?
    static var buttonTextColor: UIColor?
    static var buttonBackgroundColor: UIColor?
    
    /// Default Theme
    static public func defaultTheme() {
        self.backgroundColor = UIColor.white
        self.buttonTextColor = UIColor.blue
        self.buttonBackgroundColor = UIColor.white
        updateDisplay()
    }
    
    /// Set dark theme
    static public func darkTheme() {
        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
        self.buttonBackgroundColor = UIColor.black
        updateDisplay()
    }
    
    /// Set Button appearance
    static public func updateDisplay() {
        let proxyButton = UIButton.appearance()
        proxyButton.setTitleColor(Theme.buttonTextColor, for: .normal)
        proxyButton.backgroundColor = Theme.buttonBackgroundColor

        let proxyView = UIView.appearance()
        proxyView.backgroundColor = backgroundColor
    }
}
