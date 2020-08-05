//
//  Slide.swift
//  FlowGuide
//
//  Created by TCS on 18/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

struct OnBoardingItem {

    var imageName: String?
    var title: String?
    var description: String?
    
    // MARK: - Initilization
    
    init() { }
    
    /// Init
    /// - Parameters:
    ///   - imageName: String
    ///   - title: title
    ///   - description: description
    init(imageName: String?, title: String?, description: String?) {
        self.imageName = imageName
        self.title = title
        self.description = description
    }
    
    // MARK: - Static Methods
    
    /// Onboarding items with static values
    static var collection: [OnBoardingItem] = [
        OnBoardingItem(imageName: Constants.OnBoarding.slide1,
                       title: String.OnBoarding.onboardingTitle1.localized,
                       description: String.OnBoarding.onboardingDesc1.localized),
        OnBoardingItem(imageName: Constants.OnBoarding.slide2,
                       title: String.OnBoarding.onboardingTitle2.localized,
                       description: String.OnBoarding.onboardingDesc2.localized),
        OnBoardingItem(imageName: Constants.OnBoarding.slide3,
                       title: String.OnBoarding.onboardingTitle3.localized,
                       description: String.OnBoarding.onboardingDesc3.localized)
    ]
}
