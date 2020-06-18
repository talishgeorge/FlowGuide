//
//  UIApplication+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// Dismiss Alert
    static func dismissAlert() {
        var topController =  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if topController is UIAlertController {
            topController?.dismiss(animated: true)
        }
    }
}
