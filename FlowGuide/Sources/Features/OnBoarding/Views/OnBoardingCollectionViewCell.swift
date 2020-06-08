//
//  OnBoardingCollectionViewCell.swift
//  FlowGuide
//
//  Created by Talish George on 18/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var slideImageView: UIImageView!
    
    func configure(image: UIImage) {
        slideImageView.image = image
    }
}
