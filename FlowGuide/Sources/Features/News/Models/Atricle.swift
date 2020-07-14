//
//  Atricle.swift
//  FlowGuide
//
//  Created by TCS on 27/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

/// News Response
struct  NewsSourcesResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    
    // MARK: - Properties
    
    let title: String?
    let description: String?
    let url: String?
    let imageURL: String?
    let sourceName: String
    
    /// Coding Keys
    private enum ArticleKeys: String, CodingKey {
        case title
        case description
        case url
        case imageURL = "urlToImage"
        case source
    }
    
    /// Source Keys
    private enum SourceKeys: String, CodingKey {
        case name
    }
    
    // MARK: - Initilization
    
    /// Init
    /// - Parameter decoder: Decoder
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ArticleKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.url = try? container.decode(String.self, forKey: .url)
        self.imageURL = try? container.decode(String.self, forKey: .imageURL)
        let sourceContainer = try container.nestedContainer(keyedBy: SourceKeys.self, forKey: .source)
        self.sourceName = try sourceContainer.decode(String.self, forKey: .name)
    }
}
