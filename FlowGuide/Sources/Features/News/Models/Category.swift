//
//  Category.swift
//  FlowGuide
//
//  Created by Talish George on 27/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct Category {
    let title: String
    let articles: [Article]
}

extension Category {
    
    static func loadLocalData() -> [Category] {
        var categories = [Category]()
        do {
            if let bundlePath = Bundle.main.path(forResource: "Article", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                do {
                    let data = try JSONDecoder().decode(NewsSourcesResponse.self, from: jsonData).articles
                    let category = Category(title: "General", articles: data)
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
