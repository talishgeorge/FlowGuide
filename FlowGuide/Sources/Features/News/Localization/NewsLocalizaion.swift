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
        case title = "title_label"
        case newsFecthError = "Something went wrong"
        case newsFetchErrorMessage = "Load local JSON data?"
        case feature_enable_info = "Feature is not available"
        case news_details_feature = "News_Details_Screen"
        case on = "on"
        var tableName: String {
             "News"
        }
    }
}
