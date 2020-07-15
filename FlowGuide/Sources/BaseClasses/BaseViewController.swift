//
//  BaseViewController.swift
//  FlowGuide
//
//  Created by TCS on 24/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import OakLib
import Firebase

/// Base ViewController for all ViewController
class BaseViewController: UIViewController {

    public var navBar = CustomNavigationView.loadNavigationBar()
    public let auth = Auth.auth()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        configureUI()
    }
}

// MARK: - Internal Methods

extension BaseViewController {
    
    /// Show Alert with Actions
    /// - Parameters:
    ///   - title: String type
    ///   - message: String type
    ///   - options: Button name in String
    ///   - completion: Return Selected Action
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { _ in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Show Alert with Title
    /// - Parameters:
    ///   - title: String type
    ///   - message: String Type
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// Set Theme
    func setDarkTheme() {
        Theme.darkTheme()
    }
    
    /// Set Default Theme
    func setDefaultTheme() {
        Theme.defaultTheme()
    }
    
    func setBackGroungColor(_ rgb: Int) -> UIColor {
        return UIColor(hex: rgb)
    }
    
    /// Hide Keyboard
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    /// Setup initial UI
    func configureUI() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor ?? UIColor.systemIndigo, UIColor(named: ThemeColor.themeBottom.rawValue)?.cgColor ?? UIColor.systemTeal]
        gradient.locations = [0, 1]
        view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = view.frame
    }

    func configureButtonUI(customButton: UIView, viewButton: UIButton) {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: customButton.frame.width, height: customButton.frame.height))
        newView.clipsToBounds = true
        newView.layer.cornerRadius = customButton.frame.height/2
        newView.layer.borderWidth = 0.8
        newView.layer.borderColor = UIColor.white.cgColor
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor ?? UIColor.systemIndigo, UIColor(named: ThemeColor.themeBottom.rawValue)?.cgColor ?? UIColor.systemTeal]
        gradient.locations = [0, 1]
        newView.layer.insertSublayer(gradient, at: 0)
        gradient.frame = newView.frame
        // Add UIView as a Subview
        customButton.addSubview(newView)
        customButton.addSubview(viewButton)
    }

}
// MARK: - Custom Navigation

extension BaseViewController {
    
    func configureCustomNavigaionView() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let safeGuide = self.view.safeAreaLayoutGuide
        navBar.setupSafeArea(guide: safeGuide)
        NavBarConstants.rootNavigationController = self.navigationController
        NavBarConstants.barBGColor = UIColor(named: ThemeColor.themeBlueTop.rawValue) ?? UIColor.systemBlue
        NavBarConstants.transparentBGColor = UIColor.black.withAlphaComponent(0.5)
        NavBarConstants.rightNavButtonImage = UIImage(named: "logout")!
        NavBarConstants.titleColor = UIColor.init(hexString: ThemeColor.navigationTintHex.rawValue, alpha: 1.0)
        NavBarConstants.transparentTitleColor = UIColor.init(hexString: ThemeColor.navigationTintHex.rawValue, alpha: 1.0)
        NavBarConstants.titleFont = (UIFont.init(name: FontType.avenirNextCondensed.rawValue, size: 23) ?? nil)!
        navBar.configureNavigationBar()
    }
}
