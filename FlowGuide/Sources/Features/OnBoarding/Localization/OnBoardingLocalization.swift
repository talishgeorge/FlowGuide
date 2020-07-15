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
        case getStarted
        case onboardingTitle1
        case onboardingTitle2
        case onboardingTitle3
        var tableName: String {
            return "OnBoarding"
        }
    }
}
