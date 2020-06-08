//
//  DateFormatter+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

enum DateFormat: String {
    case flyingBlueFormat = "dd MMMM yyyy"
    case defaultFormat = "yyyy-MM-dd"
    case isoDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ'"
    case hoursMinutesFormat = "HH:mm"
    case detailedFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    case apiFormat = "yyyy-MM-dd'T'HH:mm':00.000Z'"
    case dateTimeFormat = "dd/MM/yyyy HH:mm"
    case weekDayMonthFormat = "EEE dd MMM"
    case apiDepartureDateFormat = "yyyy-MM-dd'T'HH:mmZZZZZ"
    case dateOfBirth = "dd-MM-yyyy"
    case serviceFormat = "yyyy-MM-dd'T'HH:mmZ"
    case formateTripDate = "yyyy-MM-dd'T'HH:mm"
    
}

enum Timezone: String {
    case utc = "UTC"
    case cet = "CET"
    case none
}

enum DateConstants {
    static let locale = "en_US_POSIX"
}

var currentDate: Date {
    Date()
}

var localePOSIX: Locale {
    Locale(identifier: DateConstants.locale)
}

var formatterUTC: DateFormatter? {
    DateFormatter.formatter(with: .serviceFormat, forLocale: localePOSIX, withZone: Timezone.utc)
}

extension DateFormatter {
    
    static func formatter(with dateFormat: DateFormat = .defaultFormat,
                          forLocale expectedLocale: Locale? = nil,
                          withZone expectedZone: Timezone = .none) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        if expectedZone != .none {
            dateFormatter.timeZone = TimeZone(abbreviation: expectedZone.rawValue)
        }
        if let locale = expectedLocale {
            dateFormatter.locale = locale
        }
        return dateFormatter
    }
    
    static func findDifference(from startDate: Date,
                               to endDate: Date,
                               component: Calendar.Component = .year) -> Int? {
        let years = Calendar.current.dateComponents([component], from: startDate, to: endDate).year
        return years
    }
}
