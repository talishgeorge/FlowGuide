//
//  OnBoardingViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

/// Onboarding item
struct OnboardingItemInfo {
    var title: String?
    var description: String?
}

/// OnBoarding View Model
final class OnBoardingViewModel: BaseViewModel {
    
    // MARK: - Properties
    
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
    
    /// Set Onboarding Item
    /// - Parameter index: Int
    func getCurrentOnboardingItemInfo(index: Int) -> OnboardingItemInfo {
        currentSlide = OnBoardingItem.colllection[index]
        var onboardingItemInfo = OnboardingItemInfo()
        onboardingItemInfo.title = currentSlide?.title
        onboardingItemInfo.description = currentSlide?.description
        return onboardingItemInfo
    }
    
    /// Get Onboard Item Count
    func getOnboardingItemCount() -> Int {
        return OnBoardingItem.colllection.count
    }
    
    /// Get Onboard Item Image
    /// - Parameter index: Int
    func getOnboardingItemImageName(index: Int) -> String? {
        currentSlide = OnBoardingItem.colllection[index]
        return onboardingItemImageName
    }
}
