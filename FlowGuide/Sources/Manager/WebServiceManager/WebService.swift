//
//  WebService.swift
//  WeatherForecast
//
//  Created by TCS on 07/06/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import UIKit

typealias SuccessCompletionBlock = (_ resoponse: ([Category])) -> Void
typealias FailureBlock = (_ error: Error?) -> Void

/// Web Service Class
class WebService {
    func getNews(category: String?, completion: @escaping(Swift.Result<NewsSourcesResponse, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: NewsRequestModel()) { (result) in
            completion(result)
        }
    }
}
