//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UIKit
import NetWorkLib

/// Web Service Class
final class WebService {
    
    func getNews(category: String?, completion: @escaping(Swift.Result<NewsSourcesResponse, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: NewsRequestModel()) { (result) in
            completion(result)
        }
    }
    
    func getWeather(by cityName: String, completion: @escaping(Swift.Result<ForecastWeatherResponse?, ErrorModel>) -> Void) {
        ServiceManager.shared.load(ForecastWeatherResponse.by(cityName: cityName)) { weather in
            DispatchQueue.main.async {
                completion(weather)
            }
        }
    }
}
