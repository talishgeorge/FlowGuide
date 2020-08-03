//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import OakLib
import UtilitiesLib

class ForecastViewModel: BaseViewModel, ObservableObject {
    
    @Published var weatherForCast = ForecastWeatherResponse()
    var cityName: String = "Kochi"
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
            let formattedString = String(format: "%.0f", temp/9.5)
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
            let formattedString = String(format: "%.0f", temp/8.5)
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
        ActivityIndicator.show()
        webService.getWeather(by: cityName) { forecast in
            switch forecast {
            case Result.success(let response):
                DispatchQueue.main.async {
                    guard let response = response else {
                        ActivityIndicator.dismiss()
                        return
                    }
                    closureSelf.weatherForCast = response
                    ActivityIndicator.dismiss()
                }
            case Result.failure( _):
                DispatchQueue.main.async {
                    ActivityIndicator.dismiss()
                }
            }
        }
    }
}
