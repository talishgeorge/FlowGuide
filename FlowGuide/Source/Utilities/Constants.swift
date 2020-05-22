//
//  Constants.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct K {
    
    struct Segue {
        static let showOnBoardingScreen = "showOnBoarding"
        static let showLoginSignup = "showLoginSignup"
        static let showNewsDetail = "showNewsDetail"
    }
    
    struct StoryBoardID {
        static let main  = "Main"
        static let mainTabBarController  = "MainTabBarController"
        static let onBoardingViewController  = "OnBoardingViewController"
    }
    
    struct CellIdentifiers {
           static let newsHeaderCell  = "NewsHeaderView"
           static let newsCell  = "NewsTableViewCell"
       }
}
