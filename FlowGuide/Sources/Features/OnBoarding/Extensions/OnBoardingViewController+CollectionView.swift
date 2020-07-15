//
//  OnBoardingViewController+CollectionView.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib

// MARK: - Internal Delegate Methods
extension OnBoardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    /// CollectionView delegate
    /// - Parameters:
    ///   - collectionView: Return UICollectionView Cell
    ///   - indexPath: Index Path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReUseIdentifier.onBoardingColletionViewCell, for: indexPath) as? OnBoardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = viewModel.getOnboardingItemImageName(index: indexPath.row) ?? ""
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
    
    /// CollectionView delegate
    /// - Parameters:
    ///   - collectionView: Return OnBoarding Items Count
    ///   - section: Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         viewModel.getOnboardingItemCount()
    }
    
    /// CollectonView delegate
    /// - Parameters:
    ///   - collectionView: Return frame size
    ///   - collectionViewLayout: UICollectionView Layout
    ///   - indexPath: Index Path
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         collectionView.frame.size
    }
    
    /// CollectionView Spacing for Section
    /// - Parameters:
    ///   - collectionView:Minimum Line Spacing For Section
    ///   - collectionViewLayout: CollectionView Layout
    ///   - section: Section Int
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         0
    }
}
