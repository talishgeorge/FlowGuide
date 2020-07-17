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
        OnBoardingItem(imageName: "slide1",
                       title: "Why Use MVVM",
                       description: "This app is all about to learn the MVVM design pattern. MVVM Allows to decouple the business  logic from the UI"),
        OnBoardingItem(imageName: "slide2",
                       title: "Why Use MVVM - Tip 1",
                       description: "MVVM Allows Code reuse"),
        OnBoardingItem(imageName: "slide3",
                       title: "Why Use MVVM - Tip 2",
                       description: "By having a separation between the different parts of an app's code it brings a level of structure and uniformity to the code")
    ]
}
