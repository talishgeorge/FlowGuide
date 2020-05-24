//
//  Slide.swift
//  FlowGuide
//
//  Created by Talish George on 18/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct Slide {
    
    // MARK: - Properties
    
    var imageName: String?
    var title: String?
    var description: String?
    
    // MARK: - Initilization
    
    init(){}
    
    init(imageName: String?, title: String?, description: String?) {
        self.imageName = imageName
        self.title = title
        self.description = description
    }
    
    // MARK: - Static Methods
    
    static var colllection: [Slide] = [
        Slide(imageName: "slide1",
              title: "Why Use MVVM",
              description: "This app is all about to learn the MVVM design pattern. MVVM Allows to decouple the business  logic from the UI"),
        Slide(imageName: "slide2",
              title: "Why Use MVVM - Tip 1",
              description: "MVVM Allows Code reuse"),
        Slide(imageName: "slide3",
              title: "Why Use MVVM - Tip 2",
              description: "By having a separation between the different parts of an app's code it brings a level of structure and uniformity to the code")
    ]
}
