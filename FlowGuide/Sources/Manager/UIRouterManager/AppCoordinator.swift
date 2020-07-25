//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit
import UtilitiesLib
import Combine

final class AppCoordinator: BaseCoordinator, Coordinator {

    func start() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = navController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        showLoading()
    }
    
    // MARK: - Navigation
    func showLoading() {
        let loadingViewController = UIStoryboard.instantiateLoadingViewController()
        navController.setViewControllers([loadingViewController], animated: true)
        childCoordinators.removeAll { $0 is OnBoardingCoordinator }
        loadingViewController.publisher
        .handleEvents(receiveOutput: { [unowned self] newItem in
            self.showOnboarding()
        })
        .sink { _ in }
        .store(in: &subscriptions)
    }
    
    private func showOnboarding() {
        let onBoardingCoordinator = OnBoardingCoordinator(navController: navController)
        childCoordinators.append(onBoardingCoordinator)
        onBoardingCoordinator.start()
    }
}
