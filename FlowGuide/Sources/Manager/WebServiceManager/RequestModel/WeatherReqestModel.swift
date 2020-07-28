//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import NetWorkLib

/// API Request Model
final class WeatherReqestModel: RequestModel {
    
    var cityName: String
    
    init(city: String) {
        self.cityName = city
    }
    
    override var path: String {
        ServiceManager.shared.baseURL = APIEndPoints.weatherBaseURL
        return APIEndPoints().getWeatherURL(cityName: cityName)
    }
}
