//
//  ArticleViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

/// Article View Model
struct ArticleViewModel {
    // MARK: - Properties
    
    private(set) var article: Article
}

extension ArticleViewModel {
    
    // MARK: - Initilization
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    // MARK: - Properties
    
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
