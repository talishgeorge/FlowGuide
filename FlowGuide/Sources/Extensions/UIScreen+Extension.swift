//
//  UIScreen+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /// Set Screen Size
    static func screenSize() -> CGSize {
        self.main.bounds.size
    }
}
