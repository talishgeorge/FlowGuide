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
class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
        showCaption(atIndex: 0)
    }
    
    private func setupCollectionView() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = true
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = Slide.colllection.count
    }
    
    @IBAction func userTappedOnBoarding(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.showLoginSignup, sender: nil)
    }
    
    private func showCaption(atIndex index: Int) {
        let slide = Slide.colllection[index]
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.showLoginSignup {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ReUseIdentifier.onBoardingColletionViewCell, for: indexPath) as? OnBoardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = Slide.colllection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.colllection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        showCaption(atIndex: index)
        pageControl.currentPage = index
    }
}

extension OnBoardingViewController: OnBoardingDelegate {
    func showMainTabBarController() {
        if let presentedViewController = self.presentedViewController as? LoginViewController {
            presentedViewController.dismiss(animated: true) {
                PresenterManager.shared.show(vc: .mainTabBarConttoller)
            }
        }
    }
}
