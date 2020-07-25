//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit

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
        let onBoardingVC = UIStoryboard.instantiateOnBoardingViewController(delegate: self)
        navController.setViewControllers([onBoardingVC], animated: true)
    }
}

extension OnBoardingCoordinator: OnBoardingDelegate {
    func showMainTabBarController() {
        //todo
    }
}
