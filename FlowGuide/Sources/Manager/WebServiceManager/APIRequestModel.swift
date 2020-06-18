//
//  APIRequestModel.swift
//  WeatherForecast
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Alamofire
import UIKit

/// API Request Model
struct APIRequestModel {
    var url: URL?
    var httpMethod: HTTPMethod = .get
    var parameters: [String: Any]?
    var encoding: ParameterEncoding = JSONEncoding.default
    var headers: [String: String]?
}
