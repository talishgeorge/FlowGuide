//
//  PresenterManager.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {

    static var deviceSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    static func isIpad() -> Bool {
        self.current.userInterfaceIdiom == .pad
    }
    
    static func isIPhoneX() -> Bool {
        guard self.current.userInterfaceIdiom == .phone,
            (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0) > 20.0 else {
                return false
        }
        return true
    }
    
    static func isIpadPro() -> Bool {
        guard deviceSize.height == 768 else {
            return true
        }
        return false
    }
    
    static func getAdditionalPaddingIfIphoneX() -> CGFloat {
        self.isIPhoneX() ? 20 : 0
    }

    static func isDeviceiPhone5OrLess() -> Bool {
        if
            self.current.userInterfaceIdiom == .phone,
            deviceSize.height <= 568.0 {
            return true
        }
        return false
    }
    
    static func switchOnBatteryMonitoring() {
        self.current.isBatteryMonitoringEnabled = true
    }

    static func isiPhone5ORLess() -> Bool {
        UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) <= 568.0
    }
}
