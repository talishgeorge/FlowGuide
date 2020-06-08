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
    
    var title: String
    var description: String?
    var url: String?
    var imageUrl: String?
    
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



