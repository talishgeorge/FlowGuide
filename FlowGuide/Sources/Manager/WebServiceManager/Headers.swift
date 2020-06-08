//
//  Headers.swift
//  WeatherForecast
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//


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
