//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation

class ForecastViewModel: BaseViewModel, ObservableObject{
    var cityName: String = "Kochi"
    @Published var isValid: Bool = false
    @Published var weatherForCast = ForecastWeatherResponse()
    var currentCity: String {
        if let city = weatherForCast.name {
            return city
        } else {
            return ""
        }
    }
    
    var currentCountry: String {
        if let country = weatherForCast.sys?.country {
            return country
        } else {
            return""
        }
    }
    
    var weatherDay: String {
        if let day = weatherForCast.dt {
            let formattedDay = Helper().timeConverter(timeStamp: day, isDay: false)
            return formattedDay
        } else {
            return ""
        }
    }
    
    var temperature: String {
        if let temp = weatherForCast.main?.temp {
            let formattedString = String(format: "%.0f", temp)
            return formattedString + "°"
        } else {
            return ""
        }
    }
    
    var weatherDescription: String {
        if let desc = weatherForCast.weather?.first?.description {
            print(desc)
            return desc.capitalized(with: .current)
        } else {
            return ""
        }
    }
    
    var windSpeed: String {
        if let wind = weatherForCast.wind?.speed {
            let formattedWindSpeed = String(format: "%.1f", (wind))
            return  formattedWindSpeed + "mi/h"
        } else {
            return ""
        }
    }
    
    var tempMax: String {
        if let temp = weatherForCast.main?.temp_max {
            let formattedString = String(format: "%.0f", temp)
            return formattedString + "°"
        } else {
            return ""
        }
    }
    
    var humidity: String {
        if let humidity = weatherForCast.main?.humidity {
            let formattedWindhumidity = String(humidity)
            return  formattedWindhumidity + ""
        } else {
            return ""
        }
    }
    
    var date: Int {
        if let day = weatherForCast.dt {
            return day
        } else {
            return 0
        }
    }
    
    func searchCity() {
        if let city = self.cityName
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeatherForecast(by: city)
        }
    }
    
    /// Fetch News
    /// - Parameter category: String
    func fetchWeatherForecast(by cityName: String) {
        let closureSelf = self
        webService.getWeather(by: cityName) { forecast in
            switch forecast {
            case Result.success(let response):
                DispatchQueue.main.async {
                    closureSelf.weatherForCast = response!
                }
            case Result.failure(let error):
                DispatchQueue.main.async {
                    //closureSelf.delegate?.service(self, didFinishWithError: error)
                    print("Failure \(error)")
                }
            }
        }
    }
}
