//
//  WebService.swift
//  WeatherForecast
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

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
        let requestModel = APIRequestModel(url: url,
                                           httpMethod: .get,
                                           parameters: nil,
                                           encoding: URLEncoding.default,
                                           headers: nil)
        RequestHandler.shared().request(requestModel: requestModel) { [weak self] response in
            self?.handleResponseJSON(response, success: success, failure: failure)
        }
    }
    
    /// Handle JSON response from API
    /// - Parameters:
    ///   - response:The server's response to the URL request.
    ///   - success: SuccessCompletionBlock
    ///   - failure: FailureBlock
    func handleResponseJSON(_ response: DataResponse<Any>, success: @escaping SuccessCompletionBlock, failure: @escaping FailureBlock) {
        switch response.result {
        case .success:
            if let json = response.result.value as? [String: Any] {
                handleCodableData(from: json, success: success, failure: failure)
            } else {
                extractErrorValues(response: response)
            }
        case .failure(let error):
            guard let code = response.response?.statusCode else {
                _ = CommonErrorsUtility(jsonData: response.data, withOption: .mutableContainers)
                print("Invalid status code")
                failure(nil)
                return
            }
            let errorHandler = CommonErrorsUtility(jsonData: response.data, withOption: .mutableContainers)
            let customError = NSError(domain: "", code: errorHandler.errorCode ?? code, userInfo: [ NSLocalizedDescriptionKey: error.localizedDescription ]) as Error
            _ = ErrorProvider(handler: errorHandler)
            extractErrorValues(response: response)
            failure(customError)
        }
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
    
    /// Show error based on response
    /// - Parameter response:The server's response to the URL request.
    func extractErrorValues(response: DataResponse<Any>) {
        guard case let .failure(error) = response.result else { return }
        
        if let error = error as? AFError {
            extractError(error)
            print("Underlying error: \(String(describing: error.underlyingError))")
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
        } else {
            print("Unknown error: \(error)")
        }
    }
}

private extension WebService {
    
    /// Error for each case
    /// - Parameter error: Alamofire Error type
    func extractError(_ error: AFError) {
        switch error {
        case .invalidURL(let url):
            print("Invalid URL: \(url) - \(error.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            print("Parameter encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            print("Multipart encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .responseValidationFailed(let reason):
            print("Response validation failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
            
            switch reason {
            case .dataFileNil, .dataFileReadFailed:
                print("Downloaded file could not be read")
            case .missingContentType(let acceptableContentTypes):
                print("Content Type Missing: \(acceptableContentTypes)")
            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
            case .unacceptableStatusCode(let code):
                print("Response status code was unacceptable: \(code)")
            }
        case .responseSerializationFailed(let reason):
            print("Response serialization failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        }
    }
}
