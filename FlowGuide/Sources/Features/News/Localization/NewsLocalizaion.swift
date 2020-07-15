//
//  NewsLocalizaion.swift
//  FlowGuide
//
//  Created by TCS on 25/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

/// News Localization
extension String {
    enum News: String, Localizable {
        case title
        case newsFecthError
        case newsFetchErrorMessage
        case featureEnableInfo
        case newsDetailsFeature
        case on
        var tableName: String {
             "News"
        }
    }
}
