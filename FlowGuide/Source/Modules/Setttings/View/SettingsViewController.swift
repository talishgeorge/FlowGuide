//
//  SettingsViewController.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import MBProgressHUD
import Loaf

class SettingsViewController:UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.title = K.NavigationTitle.settings
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 2.0) { [weak self] in
            guard let this = self else {
                return
            }
            let result = this.authManager.logoutUser()
            
            switch result {
            case .success:
                PresenterManager.shared.show(vc: .onBoarding)
            case .failure(let error):
                print ("Error signing out: %@", error.localizedDescription)
                Loaf(error.localizedDescription, state: .error, location: .top, sender: this).show(.custom(20)) { dismissalType in
                    switch dismissalType {
                    case .tapped: print("Tapped!")
                    case .timedOut: print("Timmed out!")
                    }
                }
            }
            MBProgressHUD.hide(for: this.view, animated: true)
        }
    }
}
