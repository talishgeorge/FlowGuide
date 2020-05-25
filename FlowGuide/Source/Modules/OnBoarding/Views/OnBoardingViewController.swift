//
//  OnBoardingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 18/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

protocol OnBoardingDelegate: class {
    func showMainTabBarController()
}

class OnBoardingViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
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
        if segue.identifier == K.Segue.showLoginSignup {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func userTappedOnBoarding(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.showLoginSignup, sender: nil)
    }
}

// MARK: - Private Functions

private extension OnBoardingViewController {
    
    private func setupCollectionView() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear//.systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = true
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.getOnboardingItemCount()
    }
    
    private func setupUIForLocalization() {
        getStartedButton.setTitle(LoginLocalization.forget_password.localized, for: .normal)
    }
}

// MARK: - Internal Methods

extension OnBoardingViewController {
    
    func showCaption(atIndex index: Int) {
        let onboardingItemInfo = viewModel.getCurrentOnboardingItemInfo(index: index)
        titleLabel.text = onboardingItemInfo.title
        descriptionLabel.text = onboardingItemInfo.description
    }
}

// MARK: - OnBoarding Delegate Methods

extension OnBoardingViewController: OnBoardingDelegate {
    
    func showMainTabBarController() {
        if let presentedViewController = self.presentedViewController as? LoginViewController {
            presentedViewController.dismiss(animated: true) {
                PresenterManager.shared.show(vc: .mainTabBarConttoller)
            }
        }
    }
}
