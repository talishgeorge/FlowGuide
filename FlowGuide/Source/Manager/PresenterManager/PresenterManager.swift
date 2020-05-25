//
//  PresenterManager.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class PresenterManager {
    
    // MARK: - Properties
    static let shared = PresenterManager()
    private init() {}
    
    enum ViewMode {
        case mainTabBarConttoller
        case onBoarding
    }
    
    // MARK: - Internal Methods
    
    func show(viewMode: ViewMode) {
        var viewController: UIViewController
        
        switch viewMode {
        case .mainTabBarConttoller:
            viewController = UIStoryboard(name: K.StoryBoardID.main,
                                          bundle: nil).instantiateViewController(withIdentifier: K.StoryBoardID.mainTabBarController)
        case .onBoarding:
            viewController = UIStoryboard(name: K.StoryBoardID.main,
                                          bundle: nil).instantiateViewController(withIdentifier: K.StoryBoardID.onBoardingViewController)
        }
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
}
