//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 15/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delay(durationInSeconds: 2.0, completion: {
            self.showInitialView()
        })
    }

    private func showInitialView() {
        if authManager.isUserLoggedIn() {
            PresenterManager.shared.show(vc: .mainTabBarConttoller)
        }else {
            performSegue(withIdentifier: K.Segue.showOnBoarding, sender: nil)
        }
    }
}
