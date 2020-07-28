//
//  Constants.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import  UIKit

/// Constants
struct Constants {
    
    /// Authentication error type
    enum AuthError: Error {
        case unknownError
    }
    
    /// Navigation Title Name
    struct NavigationTitle {
        static let settings = "Settings"
        static let home = "Home"
    }
    
    /// Segue Constants
    struct Segue {
        static let showOnBoarding = "showOnBoarding"
        static let showLoginSignup = "showLoginSignup"
        static let showNewsDetail = "showNewsDetail"
    }
    
    /// StoryBoard Id
    struct StoryBoardID {
        static let main  = "Main"
        static let mainTabBarController  = "MainTabBarController"
        static let onBoardingViewController  = "OnBoardingViewController"
    }
    
    /// Cell Identifiers
    struct CellIdentifiers {
        static let newsHeaderCell  = "NewsHeaderView"
        static let newsCell  = "NewsTableViewCell"
    }
    
    /// Reuse Identifiers
    struct ReUseIdentifier {
        static let onBoardingColletionViewCell = "cellId"
    }
    
    struct CoreApp {
        static let loggedIn = "Logged in -"
    }
}

/// API Constants
struct ApiConstants {
    static let apiKey = "6a3ce0a5c952460fb0ea2fd9163d9ddf"
    static let baseUrl = "https://newsapi.org"
    static let newsOpenURL =  "https://newsapi.org/v2/top-headlines?category=General&country=us&apiKey=6a3ce0a5c952460fb0ea2fd9163d9ddf"
    static let openWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=London,uk&Appid=315a5a4dae4ad2b0554677c7fdfdada1"
    static let newsUrl = "https://samples.openweathermap.org/data/2.5/forecast/daily?q=M%C3%BCnchen,DE&appid=b6907d289e10d714a6e88b30761fae22"
    static let newsCategory = "General"
    static let article = "Article"
    static let decodingType = "json"
}

/// Split IO Constants
struct SplitAPI {
    static let apiKey = "vog4cgfglueelkiherg7a169p09p673fsldh"
    static let customerID = "CUSTOMER_ID"
}
