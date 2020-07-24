//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case uat
    case production
    case staging
}

/// API Endpoints 
struct APIEndPoints {
    static let news: String = "top-headlines?category=General&country=us&apiKey=6a3ce0a5c952460fb0ea2fd9163d9ddf"
    static let weatherBaseURL: String = "https://api.openweathermap.org/data/2.5/"
    func getWeatherURL(cityName: String) -> String {
        "weather?q=\(cityName)&Appid=315a5a4dae4ad2b0554677c7fdfdada1"
    }
}
