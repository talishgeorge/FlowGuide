//
//  SettingsViewController.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import MBProgressHUD
import Loaf
import OakLib

/// Settings ViewController
class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let loginViewModel = LoginViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NavBarConstants.titleText = SettingsLocalization.settings.localized
        configureCustomNavigaionView()
        navBar.onRightButtonAction = { success in
            self.logout()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Private Methods

extension SettingsViewController {
    
    /// Initial SetUp
    private func setupViews() {
        self.title = SettingsLocalization.settings.localized
    }
}

// MARK: - IBActions

private extension SettingsViewController {
    
    /// Logout the current user
    func logout() {
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 2.0) { [weak self] in
            guard let this = self else {
                return
            }
            let result = this.loginViewModel.logoutUser()
            
            switch result {
            case .success:
                PresenterManager.shared.show(viewMode: .onBoarding)
            case .failure(let error):
                print("Error signing out: %@", error.localizedDescription)
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
    
    /// Logout
    /// - Parameter sender: UIBarButtonItem Type
    @IBAction private func logoutAction(_ sender: UIBarButtonItem) {
        logout()
    }
}
