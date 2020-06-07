//
//  News.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

class NewsViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    var news:[Category] = [Category(title: "Sample", articles: [])]
    
    override init() {}
    
    init(newsList:[Category]) {
        self.news = newsList
    }
}

