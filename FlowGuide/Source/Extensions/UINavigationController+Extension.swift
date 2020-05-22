//
//  PresenterManager.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let viewController = viewControllers.filter({ $0.isKind(of: ofClass) }).last {
            popToViewController(viewController, animated: animated)
        }
    }
}
