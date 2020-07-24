//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import NetWorkLib

/// API Request Model
final class WeatherReqestModel: RequestModel {
    override var path: String {
        ServiceManager.shared.baseURL = "https://api.openweathermap.org/data/2.5/"
        return ServiceConstant().getWeatherURL(cityName: "Delhi")
    }
}
