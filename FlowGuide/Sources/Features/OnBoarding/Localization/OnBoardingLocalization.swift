//
//  OnBoardingLocalization.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

/// OnBoarding Localization
extension String {
    enum OnBoarding: String, Localizable {
        case get_started_key = "get_started"
        case onboarding_title1_key = "onboarding_title1"
        case onboarding_title2_key = "onboarding_title2"
        case onboarding_title3_key = "onboarding_title3"
        var tableName: String {
             "OnBoarding"
        }
    }
}
