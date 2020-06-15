//
//  ArticleViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

struct ArticleViewModel {
    private(set) var article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: String {
        return self.article.title ?? ""
    }
    
    var description: String? {
        return self.article.description
    }
    
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
