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
import SwiftUI
import Combine

/// Settings ViewController
final class SettingsViewController: BaseViewController {
    
    @IBOutlet private weak var switchOutlet: UISwitch!
    @IBOutlet private weak var pushNotificationView: UIView!
    @IBOutlet private weak var weatherView: UIView!
    
    @IBOutlet private weak var weatherInnerView: UIView!
    @IBOutlet private weak var darkModeInnerView: UIView!
    
    @Published var isDarkModeEnabled = Bool()
    var viewModel = ForecastViewModel()
    
    @IBSegueAction func showWeather(_ coder: NSCoder) -> UIViewController? {
        let contentView = ContentView(forcastViewModel: viewModel)
        return UIHostingController(coder: coder, rootView: contentView)
    }
    
    private let settingsViewModel = SettingsViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NavBarConstants.titleText = SettingsLocalization.settings.localized
        navBar.onRightButtonAction = { success in
            self.logout()
        }
        $isDarkModeEnabled.receive(subscriber: BaseViewController())
        $isDarkModeEnabled.receive(subscriber: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addSubview(navBar)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        configureCustomNavigaionView()
        navBar.startHorizontalProgressbar()
        delay(durationInSeconds: 3.2, completion: {
            self.navBar.hideProgressBar()
        })
    }
    
    override func receive(_ input: Bool) -> Subscribers.Demand {
        delay(durationInSeconds: 0.3, completion: {
            self.applyTheme()
        })
        return .none
    }
    
     func applyTheme() {
        removeGradient(gradientView: view)
        configureUI()
        configureCustomNavigaionView()
        setupViews()
        self.tabBarController?.tabBar.backgroundColor = ThemeManager.shared.theme?.tabBarBgColor
        
    }
    
    @IBAction private func enableDardMode(_ sender: UISwitch) {
        
        isDarkModeEnabled = sender.isOn ? true : false
    }
}

// MARK: - Private Methods

private extension SettingsViewController {
    
    /// Initial SetUp
    func setupViews() {
        self.title = SettingsLocalization.settings.localized
        pushNotificationView.layer.borderWidth = SettingsConstants.viewBorderWidth
        pushNotificationView.layer.borderColor = ThemeManager.shared.theme?.borderColor.cgColor
        weatherView.layer.borderWidth = SettingsConstants.viewBorderWidth
        weatherView.layer.borderColor = ThemeManager.shared.theme?.borderColor.cgColor
        switchOutlet.onTintColor = ThemeManager.shared.theme?.switchOnTint
        darkModeInnerView.backgroundColor = ThemeManager.shared.theme?.viewDarkColor
        weatherInnerView.backgroundColor = ThemeManager.shared.theme?.viewDarkColor
        
    }
    
    /// Logout the current user
    func logout() {
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        let result = settingsViewModel.authService.logoutUser()
        switch result {
        case .success:
            baseSubject.send("Do Logout")
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
