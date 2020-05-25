//
//  CoreAPIRequestModel.swift
//  WeatherForecast
//
//  Created by 1276121 on 16/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//
import Alamofire
import Foundation

struct APIRequestModel {
    var url: URL?
    var httpMethod: HTTPMethod = .get
    var parameters: [String: Any]?
    var encoding: ParameterEncoding = JSONEncoding.default
    var headers: [String: String]?
}
