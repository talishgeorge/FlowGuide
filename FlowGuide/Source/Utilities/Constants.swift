//
//  Constants.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct K {
    
    struct NavigationTitle {
        static let settings = "Settings"
        static let home = "Home"
    }
    
    struct Segue {
        static let showOnBoarding = "showOnBoarding"
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
    
    struct ReUseIdentifier {
        static let onBoardingColletionViewCell = "cellId"
    }
}
