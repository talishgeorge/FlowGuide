//
//  SceneDelegate.swift
//  FlowGuide
//
//  Created by TCS on 15/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard scene as? UIWindowScene != nil else {
            return
        }
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navController: navController, window: window)
        guard let appCoordinator = appCoordinator else {
            return
        }
        appCoordinator.start()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
