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
        var articles = [Article]()
        var article1 = Article()
        article1.title = "11222"
        article1.description = "Ddddddd"
        articles.append(article1)
        var article2 = Article()
        article2.title = "113333"
        article2.description = "Eeeeeee"
        articles.append(article2)
        var categories = [Category]()
        let category = Category(title: "General", articles: articles)
        categories.append(category)
        return categories
    }
}
