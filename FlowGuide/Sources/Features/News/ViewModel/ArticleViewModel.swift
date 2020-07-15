//
//  ArticleViewModel.swift
//  FlowGuide
//
//  Created by TCS on 07/06/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import UIKit

/// Article View Model
struct ArticleViewModel {
    private(set) var article: Article
}

// MARK: - Internal Methods
extension ArticleViewModel {
        
    init(_ article: Article) {
        self.article = article
    }
}

// MARK: - Internal Methods for Article Model

extension ArticleViewModel {
 
    /// Title
    var title: String {
        return self.article.title ?? ""
    }
    
    /// Description
    var description: String? {
        return self.article.description
    }
    
    /// Set Image from URL
    /// - Parameter completion: UIImage Type
    func image(completion: @escaping (UIImage?) -> Void) {
        
        guard let imageURL = article.imageURL else {
            completion(UIImage.imageForPlaceHolder())
            return
        }
        UIImage.imageForHeadline(url: imageURL) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
