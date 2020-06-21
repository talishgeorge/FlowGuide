//
//  OnBoardingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 18/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

//import Foundation
import UIKit

/// Protocol
protocol OnBoardingDelegate: class {
    func showMainTabBarController()
}

/// OnBoarding View Controller
final class OnBoardingViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var getStartedButton: UIButton!
    let viewModel = OnBoardingViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
        showCaption(atIndex: 0)
        setupUIForLocalization()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showLoginSignup {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction private func userTappedOnBoarding(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segue.showLoginSignup, sender: nil)
    }
}

// MARK: - Private Functions

private extension OnBoardingViewController {
    
    /// Collection View Setup
    private func setupCollectionView() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear//.systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = true
    }
    
    /// Set Page
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.getOnboardingItemCount()
    }
    
    /// Localization
    private func setupUIForLocalization() {
        getStartedButton.setTitle(OnBoardingLocalization.get_started_key.localized, for: .normal)
    }
}

// MARK: - Internal Methods

extension OnBoardingViewController {
    
    /// Show Caption
    /// - Parameter index: Int
    func showCaption(atIndex index: Int) {
        let onboardingItemInfo = viewModel.getCurrentOnboardingItemInfo(index: index)
        titleLabel.text = (index == 1) ? OnBoardingLocalization.onboarding_title1_key.localized:
            (index == 2) ? OnBoardingLocalization.onboarding_title2_key.localized: OnBoardingLocalization.onboarding_title3_key.localized
        descriptionLabel.text = onboardingItemInfo.description
    }
}

// MARK: - OnBoarding Delegate Methods

extension OnBoardingViewController: OnBoardingDelegate {
    
    /// Show TabBar Controller
    func showMainTabBarController() {
        if let presentedViewController = self.presentedViewController as? LoginViewController {
            presentedViewController.dismiss(animated: true) {
                PresenterManager.shared.show(viewMode: .mainTabBarConttoller)
            }
        }
    }
    
    /// ScrollView Delegate
    /// - Parameter scrollView: UIScrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        showCaption(atIndex: index)
        pageControl.currentPage = index
    }
}
