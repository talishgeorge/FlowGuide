//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

struct ResponseModel<T: Decodable>: Decodable {
    
    // MARK: - Properties
    var status: String
    var totalResults: Int
    var error: ErrorModel {
        return ErrorModel(status)
    }
    var rawData: Data?
    var data: T?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        status = (try? keyedContainer.decode(String.self, forKey: CodingKeys.status)) ?? ""
        totalResults = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.totalResults)) ?? 0
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.articles)
    }
}

// MARK: - Private Functions
extension ResponseModel {

    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case data
        case articles
    }
}
