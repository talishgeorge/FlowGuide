//
//  PresenterManager.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func dismissAlert() {
        var topController = self.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if topController is UIAlertController {
            topController?.dismiss(animated: true)
        }
    }
}
