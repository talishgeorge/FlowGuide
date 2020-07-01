//
//  RequestHandler.swift
//  WeatherForecast
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Alamofire
//import SBNLib

public class RequestHandler {
    
    /// Shared variable
    public static var sharedRequestHandler: RequestHandler = {
        let requestHandler = RequestHandler()
        return requestHandler
    }()
    
    /// Return shared request handler
    public class func shared() -> RequestHandler {
        return sharedRequestHandler
    }
    
    /// API Request
    /// - Parameters:
    ///   - requestModel:APIRequestModel
    ///   - success:response
    public func request(requestModel: APIRequestModel,
                 success: @escaping ( _ response: DataResponse<Any>) -> Void) {
        let sessionManager: Alamofire.SessionManager
        sessionManager = Alamofire.SessionManager.default
        if let baseURL = requestModel.url {
            sessionManager.request(baseURL, method: requestModel.httpMethod, parameters: requestModel.parameters, encoding: requestModel.encoding, headers: requestModel.headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    success(response)
            }
        }
    }
}
