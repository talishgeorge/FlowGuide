//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 15/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let isUserLoggedIn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialView()
    }
    
    private func setupViews() {
        view.backgroundColor = .orange
    }
    
    private func showInitialView() {
        if isUserLoggedIn {
            let mainTabBarController = UIStoryboard(name: "Main",
                                                    bundle: nil).instantiateViewController(withIdentifier: "mainTabBarController")
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                let window = sceneDelegate.window
                window?.rootViewController = mainTabBarController
            }
        }else {
            performSegue(withIdentifier: "showOnBoarding", sender: nil)
        }
    }
}
