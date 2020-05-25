//
//  NetWorkManager.swift
//  WeatherForecast
//
//  Created by 1276121 on 16/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    func request(requestModel: APIRequestModel,
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
