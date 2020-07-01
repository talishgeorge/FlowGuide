//
//  WebService.swift
//  WeatherForecast
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit
import SBNLib
import ExtensionsLib
import UtilitiesLib

typealias SuccessCompletionBlock = (_ resoponse: ([Category])) -> Void
typealias FailureBlock = (_ error: Error?) -> Void

/// Web Service Class
class WebService {
    /// Fetch News Data
    /// - Parameters:
    ///   - category: String
    ///   - success:SuccessCompletionBlock
    ///   - failure: FailureBlock
    func getNewsData(category: String?, success: @escaping SuccessCompletionBlock, failure: @escaping FailureBlock) {
        guard let url = URL(string: ApiConstants.newsOpenURL) else {
            failure(nil)
            return
        }
        RequestHandler.configureRequest(url: url, success: { news in
            self.handleCodableData(from: news, success: success, failure: failure)
        }, failure: failure)
    }
    
    /// Decode JSON data
    /// - Parameters:
    ///   - json: JSON
    ///   - success: SuccessCompletionBlock
    ///   - failure: FailureBlock
    func handleCodableData(from json: [String: Any], success: @escaping SuccessCompletionBlock, failure: @escaping FailureBlock) {
        var categories = [Category]()
        if let jsonData = json.jsonString.data(using: .utf8) {
            do {
                let data = try JSONDecoder().decode(NewsSourcesResponse.self, from: jsonData).articles
                let category = Category(title: "General", articles: data)
                categories.append(category)
                success(categories)
            } catch {
                print("Error...while decoding JSON!")
                failure(nil)
            }
        }
    }
}
