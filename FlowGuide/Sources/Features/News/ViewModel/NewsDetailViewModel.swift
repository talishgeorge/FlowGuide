//
//  NewsDetailViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 15/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

/// News Details Model
struct NewsDetailsViewModel {
    
    // MARK: - Properties
    
    let article: Article
}

extension NewsDetailsViewModel {
    
    // MARK: - Initilization
    
    init(_ article: Article) {
        self.article = article
    }
}

extension NewsDetailsViewModel {
    
    // MARK: - Properties
    
    /// Source name
    var sourceName: String {
        return self.article.sourceName
    }
    
    /// Article URL
    var url: String? {
        return self.article.url
    }
}
