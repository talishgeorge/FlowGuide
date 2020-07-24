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
    
    @IBOutlet private weak var pushNotificationView: UIView!
    private let loginViewModel = LoginViewModel()
    @Published var isDarkModeEnabled = Bool()
    var viewModel = ForecastViewModel()
    
    @IBSegueAction func showWeather(_ coder: NSCoder) -> UIViewController? {
        let contentView = ContentView(forcastViewModel: viewModel)
        return UIHostingController(coder: coder, rootView: contentView)
        
    }
    
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
        delay(durationInSeconds: 2.0, completion: {
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
        self.configureUI()
        self.configureCustomNavigaionView()
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

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
