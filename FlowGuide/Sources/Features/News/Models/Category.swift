//
//  Category.swift
//  FlowGuide
//
//  Created by Talish George on 27/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

/// Category Model
struct Category {
    // MARK: - Properties

    let title: String
    let articles: [Article]
}

extension Category {
    
    /// If API fails, Load data from Local JSON
    static func loadLocalData() -> [Category] {
        var categories = [Category]()
        do {
            if let bundlePath = Bundle.main.path(forResource: ApiConstants.article,
                                                 ofType: ApiConstants.decodingType),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                do {
                    let data = try JSONDecoder().decode(NewsSourcesResponse.self, from: jsonData).articles
                    let category = Category(title: ApiConstants.newsCategory, articles: data)
                    categories.append(category)
                } catch let error {
                    print("Error...while decoding JSON! \(error)")
                }
            }
        } catch {
            print(error)
        }
        return categories
    }
}
