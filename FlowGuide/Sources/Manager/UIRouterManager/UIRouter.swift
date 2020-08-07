//
//  UIRouter.swift
//  FlowGuide
//
//  Created by TCS on 16/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib

/// Routter for UI
final class UIRouter {
    
    static let shared = UIRouter()
    private init() {}
    
    /// View mode
    enum ViewMode {
        case mainTabBarConttoller
        case onBoarding
        var storyboardName: String {
            switch self {
            case .mainTabBarConttoller:
                return "MainTabBarController"
            case .onBoarding:
                return "OnBoardingViewController"
            }
        }
        
    }
    
    // MARK: - Internal Methods
    
    /// Show view based on the mode
    /// - Parameter viewMode: ViewMode
    func show(viewMode: ViewMode) {
        var viewController: UIViewController
        
        switch viewMode {
        case .mainTabBarConttoller:
            viewController = UIStoryboard(name: Constants.StoryBoardID.main,
                                          bundle: nil).instantiateViewController(withIdentifier: viewMode.storyboardName)
        case .onBoarding:
            viewController = UIStoryboard(name: Constants.StoryBoardID.main,
                                          bundle: nil).instantiateViewController(withIdentifier: viewMode.storyboardName)
        }
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
}
