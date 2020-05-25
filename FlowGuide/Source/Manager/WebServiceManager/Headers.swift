//
//  Headers.swift
//  WeatherForecast
//
//  Created by 1276121 on 16/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import Foundation
struct APIHeaderKeys {
    static let accept = "Accept"
    static let contentType = "Content-Type"
    static let acceptLanguage = "Accept-Language"
    static let charSet = "charset"
}

struct APIHeaders {
    static var common: [String: String] {
        let language = "en"
        return [APIHeaderKeys.accept: "application/json",
                APIHeaderKeys.contentType: "application/json",
                APIHeaderKeys.acceptLanguage: language]
    }
    static var generic: [String: String] {
        let language = "en"
        return [APIHeaderKeys.accept: "application/json",
                APIHeaderKeys.contentType: "application/json",
                APIHeaderKeys.acceptLanguage: language]
    }
}
