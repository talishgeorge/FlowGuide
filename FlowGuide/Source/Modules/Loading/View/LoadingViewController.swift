//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 15/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoadingViewController: UIViewController {
    
    private var isUserLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
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
        if isUserLoggedIn {
            PresenterManager.shared.show(vc: .mainTabBarConttoller)
        }else {
            performSegue(withIdentifier: K.Segue.showOnBoarding, sender: nil)
        }
    }
}
