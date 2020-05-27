//
//  Category.swift
//  FlowGuide
//
//  Created by Talish George on 27/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct Category {
    
    let title: String
    let articles: [Article]
    
    static func all() -> [String] {
        ["Business", "Entertaiment", "General", "Sports"]
    }
}

