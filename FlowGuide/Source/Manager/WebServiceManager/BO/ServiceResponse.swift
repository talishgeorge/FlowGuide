//
//  ServiceResponse.swift
//  FlowGuide
//
//  Created by Talish George on 25/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

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
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
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
    var weatherDescription: String?
    var icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
