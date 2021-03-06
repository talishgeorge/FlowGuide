//
//  UIImage+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Default Image placeHolder
    static func imageForPlaceHolder() -> UIImage {
        return UIImage(named: "placeholder")!
    }
    
    /// Fetch Image from URL for News Headline
    /// - Parameters:
    ///   - url: String Type
    ///   - completion: UIImage
    static func imageForHeadline(url: String, completion: @escaping (UIImage) -> Void) {
        
        guard let imageURL = URL(string: url) else {
            completion(UIImage.imageForPlaceHolder())
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                if let downloadImage = UIImage(data: data) {
                    completion(downloadImage)
                }
            }
        }
        
    }
    
}
