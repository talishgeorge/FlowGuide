//
//  NewsDetailViewModel.swift
//  FlowGuide
//
//  Created by TCS on 15/06/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

/// News Details Model
struct NewsDetailsViewModel { 
    let article: Article
}

extension NewsDetailsViewModel {
    
    // MARK: - Initilization
    
    init(_ article: Article) {
        self.article = article
    }
}

extension NewsDetailsViewModel {
    /// Source name
    var sourceName: String {
        return self.article.sourceName
    }
    
    /// Article URL
    var url: String? {
        return self.article.url
    }
}
