//
//  UIDevice+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension UIDevice {

    static var deviceSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    /// Set userInterfaceIdiom as iPad
    static func isIpad() -> Bool {
        self.current.userInterfaceIdiom == .pad
    }
    
    /// Set userInterfaceIdiom as iPhone
    static func isIPhoneX() -> Bool {
        guard self.current.userInterfaceIdiom == .phone,
            ( UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0.0) > 20.0 else {
                return false
        }
        return true
    }
    
    /// Set userInterfaceIdiom as iPadPro
    static func isIpadPro() -> Bool {
        guard deviceSize.height == 768 else {
            return true
        }
        return false
    }
    
    /// Set userInterfaceIdiom as iPhoneX
    static func getAdditionalPaddingIfIphoneX() -> CGFloat {
        self.isIPhoneX() ? 20 : 0
    }
    
    /// Set device size height as iPhone5 or less
    static func isDeviceiPhone5OrLess() -> Bool {
        if
            self.current.userInterfaceIdiom == .phone,
            deviceSize.height <= 568.0 {
            return true
        }
        return false
    }
    
    /// TurnOn Battery Monitoring
    static func switchOnBatteryMonitoring() {
        self.current.isBatteryMonitoringEnabled = true
    }
    
    /// Set device size as iPhone5 or less
    static func isiPhone5ORLess() -> Bool {
        UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) <= 568.0
    }
}
