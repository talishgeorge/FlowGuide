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
    var subscriptions = Set<AnyCancellable>()
    private var childCoordinators: [Coordinator] = []
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let onBoardingVC = UIStoryboard.instantiateOnBoardingViewController()
        navController.setViewControllers([onBoardingVC], animated: true)
    }
}
