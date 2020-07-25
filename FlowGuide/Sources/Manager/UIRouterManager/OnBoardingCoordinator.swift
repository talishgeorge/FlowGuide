//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit
import Combine

protocol OnBoardingCoordinatorDelegate: AnyObject {
    func navigateToNextPage()
}

final class OnBoardingCoordinator: Coordinator {
    private let navController: UINavigationController
    weak var delegate: OnBoardingCoordinatorDelegate?
    
    init(navController: UINavigationController, delegate: OnBoardingCoordinatorDelegate) {
        self.navController = navController
        self.delegate = delegate
    }
    
    func start() {
        let onBoardingVC = UIStoryboard.instantiateOnBoardingViewController()
        navController.setViewControllers([onBoardingVC], animated: true)
    }
    
    func startWithReturn() -> PassthroughSubject<String, Never> {
        let onBoardingVC = UIStoryboard.instantiateOnBoardingViewController()
        navController.setViewControllers([onBoardingVC], animated: true)
       return onBoardingVC.publisher
    }
}

extension OnBoardingCoordinator: OnBoardingDelegate {
    func showMainTabBarController() {
        //todo
    }
}
