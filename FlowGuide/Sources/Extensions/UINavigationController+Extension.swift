//
//  UINavigationController+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// Pop to Last View Controller
    /// - Parameters:
    ///   - ofClass: class type
    ///   - animated: bool
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let viewController = viewControllers.last(where: {$0.isKind(of: ofClass)}) {
             popToViewController(viewController, animated: animated)
        }
    }
}
