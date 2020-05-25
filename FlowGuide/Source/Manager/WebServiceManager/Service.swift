//
//  Service.swift
//  WeatherForecast
//
//  Created by 1276121 on 13/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import Foundation
import Alamofire
typealias SuccessCompletionBlock = (_ resoponse: ForecastWeatherResponse?)->()
typealias FailureBlock = (_ error: Error?) -> Void

class Services {
    
    let appID = "315a5a4dae4ad2b0554677c7fdfdada1"
    //let baseURL = "https://api.openweathermap.org/data/2.5/forecast/daily?q=London&appid=315a5a4dae4ad2b0554677c7fdfdada1"
    let baseURL = "https://samples.openweathermap.org/data/2.5/forecast/daily?q=M%C3%BCnchen,DE&appid=b6907d289e10d714a6e88b30761fae22"
    let baseOpenWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=London,uk&Appid=315a5a4dae4ad2b0554677c7fdfdada1"
    func getWeatherData(city: String?, success: @escaping SuccessCompletionBlock, failure: @escaping FailureBlock) {
        guard let url = URL(string: baseOpenWeatherURL) else {
            failure(nil)
            return
        }
        let requestModel = APIRequestModel(url: url,
                                           httpMethod: .get,
                                           parameters: nil,
                                           encoding: URLEncoding.default,
                                           headers: nil)
        NetworkManager.shared().request(requestModel: requestModel) { [weak self] response in
            self?.handleResponseJSON(response, success: success, failure: failure)
        }
    }
    
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
                let errorHandler = CommonErrorsUtility(jsonData: response.data, withOption: .mutableContainers)
                print("Invalid status code")
                failure(nil)
                return
            }
            let errorHandler = CommonErrorsUtility(jsonData: response.data, withOption: .mutableContainers)
            let customError = NSError(domain: "", code: errorHandler.errorCode ?? code, userInfo: [ NSLocalizedDescriptionKey: error.localizedDescription ]) as Error
            let customError1 = ErrorProvider(handler: errorHandler)
            extractErrorValues(response: response)
            failure(customError)
        }
    }
    
    func handleCodableData(from json: [String: Any], success: @escaping SuccessCompletionBlock, failure: @escaping FailureBlock) {
        if let jsonData = json.jsonString.data(using: .utf8) {
            do {
                let data = try JSONDecoder().decode(ForecastWeatherResponse.self, from: jsonData)
                print("Data ->", data)
                success(data)
            } catch {
                print("Error...while decoding JSON!")
                failure(nil)
            }
        }
    }
    
    func extractErrorValues(response: DataResponse<Any>) {
        guard case let .failure(error) = response.result else { return }
        
        if let error = error as? AFError {
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
            print("Underlying error: \(String(describing: error.underlyingError))")
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
        } else {
            print("Unknown error: \(error)")
        }
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    var errors: [[String: Any]]? {
        return self["_errors"] as? [[String: Any]]
    }
    
    var jsonString: String {
        do {
            guard let stringData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return "" }
            if let string = String(data: stringData, encoding: .utf8) {
                return string
            }
            return ""
        }
    }
}
