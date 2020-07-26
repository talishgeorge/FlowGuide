//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UIKit

struct AppConstants {
    static let loggedIn = "Logged in -"
    static let delaySeconds = 3
    static let UIWidth = UIScreen.main.bounds.width
}

extension AppConstants {
    /// StoryBoard Id
    struct StoryBoardID {
        static let main  = "Main"
        static let mainTabBarController  = "MainTabBarController"
        static let onBoardingViewController  = "OnBoardingViewController"
        static let loadingViewController = "LoadingViewController"
    }
    /// Segue Constants
    struct Segue {
        static let showOnBoarding = "showOnBoarding"
        static let showLoginSignup = "showLoginSignup"
        static let showNewsDetail = "showNewsDetail"
    }
    
    struct NavigationTitle {
        static let settings = "Settings"
        static let home = "Home"
    }
}
