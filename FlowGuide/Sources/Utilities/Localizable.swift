//
//  Localizable.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

/// Localization
protocol Localizable {
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
     
    // MARK: - Properties
    
    var localized: String {
        rawValue.localized()
    }
}
