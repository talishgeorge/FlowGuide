//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import NetWorkLib

// MARK: - ForecastWeatherResponse
struct ForecastWeatherResponse: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone: Int?
    var id: Int?
    var name: String?
    var cod: Int?
    
    static func by(cityName: String) -> Resource<ForecastWeatherResponse> {
        return Resource<ForecastWeatherResponse>(url: URL.urlForWeather(for: cityName)) { data in
            return try? JSONDecoder().decode(ForecastWeatherResponse.self, from: data)
        }
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lon: Double?
    var lat: Double?
}

// MARK: - Main
struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
