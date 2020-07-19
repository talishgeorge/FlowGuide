//
//  SettingsViewController.swift
//  FlowGuide
//
//  Created by TCS on 16/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import OakLib
import UtilitiesLib

/// Settings ViewController
final class SettingsViewController: BaseViewController {
    
    @IBOutlet private weak var pushNotificationView: UIView!
    private let loginViewModel = LoginViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NavBarConstants.titleText = SettingsLocalization.settings.localized
        navBar.onRightButtonAction = { success in
            self.logout()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addSubview(navBar)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        configureCustomNavigaionView()
        navBar.startHorizontalProgressbar()
        delay(durationInSeconds: 2.0, completion: {
            self.navBar.hideProgressBar()
        })
    }
}

// MARK: - Private Methods

private extension SettingsViewController {
    
    /// Initial SetUp
    func setupViews() {
        self.title = SettingsLocalization.settings.localized
        pushNotificationView.layer.borderWidth = CGFloat(SettingsConstants.viewBorderWidth)
        pushNotificationView.layer.borderColor = ThemeManager.shared.theme?.borderColor.cgColor
    }
    
    /// Logout the current user
    func logout() {
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        let result = loginViewModel.logoutUser()
        switch result {
        case .success:
            UIRouter.shared.show(viewMode: .onBoarding)
        case .failure( _):
            view.popup.topAnchor = view.safeAreaLayoutGuide.topAnchor
            view.popup.style.bar.hideAfterDelaySeconds = TimeInterval(AppConstants.delaySeconds)
            view.popup.success(String.News.featureEnableInfo.localized)
        }
        ActivityIndicator.dismiss()
    }
    
    /// Logout
    /// - Parameter sender: UIBarButtonItem Type
    @IBAction private func logoutAction(_ sender: UIBarButtonItem) {
        logout()
    }
}
