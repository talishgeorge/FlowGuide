//
//  EndPoints.swift
//  FlowGuide
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        guard let url = URL(string: path) else {
            preconditionFailure(
                "Invalid URL components"
            )
        }
        return url
    }
    
    static func news(for category: String) -> Self {
        Endpoint(path: ApiConstants.baseUrl + "/v2/top-headlines?category=\(category)&country=us&apiKey=" + ApiConstants.apiKey)
    }
}
