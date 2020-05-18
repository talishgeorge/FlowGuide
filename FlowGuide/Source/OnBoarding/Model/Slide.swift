//
//  Slide.swift
//  FlowGuide
//
//  Created by Talish George on 18/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct Slide {
    let imageName: String
    let title: String
    let description: String
    
    static let colllection: [Slide] = [
        Slide(imageName: "slide1", title: "", description: ""),
        Slide(imageName: "slide2", title: "", description: ""),
        Slide(imageName: "slide3", title: "", description: "")
    ]
}
