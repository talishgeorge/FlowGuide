//
//  UIButton+Extension.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 01/07/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension UIButton {
    
    func cornerRadiusWithBorder(button: UIButton) {
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor =  UIColor(named: "ViewBorderColour")?.cgColor
    }
}
