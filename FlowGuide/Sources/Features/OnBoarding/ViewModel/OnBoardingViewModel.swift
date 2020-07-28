//
//  OnBoardingViewModel.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

/// Onboarding item
struct OnboardingItemInfo {
    var title: String?
    var description: String?
}

/// OnBoarding View Model
final class OnBoardingViewModel: BaseViewModel {
    
    /// Current Onboarding item
    var currentSlide = OnBoardingItem()
    
    /// Onboarding item title
    var onboardingItemTitle: String {
        currentSlide.title ?? ""
    }
    
    /// Onboarding Item Description
    var onboardingItemDescription: String {
        currentSlide.description ?? ""
    }
    
    /// Onboarding Item Image name
    var onboardingItemImageName: String {
        currentSlide.imageName ?? ""
    }
}

// MARK: - Internal Methods

extension OnBoardingViewModel {
    
    /// Get Onboard Item Count
    var getOnboardingItemCount: Int {
        OnBoardingItem.collection.count
    }
    
    /// Set Onboarding Item
    /// - Parameter index: Int
    func getCurrentOnboardingItemInfo(index: Int) -> OnboardingItemInfo {
        currentSlide = OnBoardingItem.collection[index]
        let onboardingItemInfo = OnboardingItemInfo(title: currentSlide.title, description: currentSlide.description)
        return onboardingItemInfo
    }
    
    /// Get Onboard Item Image
    /// - Parameter index: Int
    func getOnboardingItemImageName(index: Int) -> String? {
        currentSlide = OnBoardingItem.collection[index]
        return onboardingItemImageName
    }
}
