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
        case loading1 = "loading_1"
        case loading2 = "loading_2"
        case loading3 = "loading_3"
        case loading = "loading_0"
        var tableName: String {
            return "Loading"
        }
    }
}
