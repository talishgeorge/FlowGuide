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
final class OnBoardingViewModel: AuthViewModel {
  
    /// Current Onboarding item
    var currentSlide: OnBoardingItem? = OnBoardingItem()
    
    /// Onboarding item title
    var onboardingItemTitle: String? {
        if let title = currentSlide?.title {
            return title
        } else {
            return ""
        }
    }
    
    /// Onboarding Item Description
    var onboardingItemDescription: String? {
        if let description = currentSlide?.description {
            return description
        } else {
            return ""
        }
    }
    
    /// Onboarding Item Image name
    var onboardingItemImageName: String? {
        if let imageName = currentSlide?.imageName {
            return imageName
        } else {
            return ""
        }
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
        var onboardingItemInfo = OnboardingItemInfo()
        onboardingItemInfo.title = currentSlide?.title
        onboardingItemInfo.description = currentSlide?.description
        return onboardingItemInfo
    }
    
    /// Get Onboard Item Image
    /// - Parameter index: Int
    func getOnboardingItemImageName(index: Int) -> String? {
        currentSlide = OnBoardingItem.collection[index]
        return onboardingItemImageName
    }
}
