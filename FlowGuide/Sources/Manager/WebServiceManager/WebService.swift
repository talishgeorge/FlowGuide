//
//  WebService.swift
//  WeatherForecast
//
//  Created by TCS on 07/06/20.
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
}
