//
//  OnBoardingViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct OnboardingItemInfo {
    var title: String?
    var description: String?
}

final class OnBoardingViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    var currentSlide: Slide? = Slide()
    
    var onboardingItemTitle: String? {
        if let title = currentSlide?.title {
            return title
        } else {
            return ""
        }
    }
    
    var onboardingItemDescription: String? {
        if let description = currentSlide?.description {
            return description
        } else {
            return ""
        }
    }
    
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
    
    func getCurrentOnboardingItemInfo(index: Int) -> OnboardingItemInfo {
        currentSlide = Slide.colllection[index]
        var onboardingItemInfo = OnboardingItemInfo()
        onboardingItemInfo.title = currentSlide?.title
        onboardingItemInfo.description = currentSlide?.description
        return onboardingItemInfo
    }
    
    func getOnboardingItemCount() -> Int {
        return Slide.colllection.count
    }
    
    func getOnboardingItemImageName(index: Int) -> String? {
        currentSlide = Slide.colllection[index]
        return onboardingItemImageName
    }
}
