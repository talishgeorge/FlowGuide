//
//  Localizable.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//
import ExtensionsLib

/// Localization
protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        rawValue.localized(tableName: tableName)
    }
}
