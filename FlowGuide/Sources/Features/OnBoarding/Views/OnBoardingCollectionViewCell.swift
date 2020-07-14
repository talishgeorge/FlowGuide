//
//  OnBoardingCollectionViewCell.swift
//  FlowGuide
//
//  Created by TCS on 18/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

/// OnBoarding Collection View Cell
class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet private weak var slideImageView: UIImageView!
    
    /// Set CollectionView Cell
    /// - Parameter image: UIImage
    func configure(image: UIImage) {
        slideImageView.image = image
    }
}
