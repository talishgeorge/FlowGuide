//
//  Atricle.swift
//  FlowGuide
//
//  Created by Talish George on 27/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct  NewsSourcesResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    
    let title: String
    let description: String?
    let url: String?
    let imageUrl: String?
    
    init() {
        self.title = ""
        self.description = ""
        self.url = ""
        self.imageUrl = ""
    }
    
    private enum CodinKeys: String, CodingKey {
        case title
        case description
        case url
        case imageUrl = "urlToImage"
    }
}

extension Article {
    static func by(_ category: String) -> Resource<[Article]> {
        return Resource<[Article]>(url: Endpoint.news(for: category).url) { (data) -> [Article]? in
            return try? JSONDecoder().decode(NewsSourcesResponse.self, from: data).articles
        }
    }
}


