//
//  LoadingLocalization.swift
//  FlowGuide
//
//  Created by TCS on 25/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

/// Loading Localizatioin

extension String {
    enum Loading: String, Localizable {
        case loading1
        case loading2
        case loading3
        case loading
        var tableName: String {
             "Loading"
        }
    }
}
