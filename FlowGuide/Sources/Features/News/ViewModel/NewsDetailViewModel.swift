//
//  NewsDetailViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 15/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct NewsDetailsViewModel {
    let article: Article
}

extension NewsDetailsViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension NewsDetailsViewModel {
    
    var sourceName: String {
        return self.article.sourceName
    }
    
    var url: String? {
        return self.article.url
    }
}
