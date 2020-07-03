//
//  BaseViewController.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import OakLib

/// Base ViewController for all ViewController
class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    public var navBar = CustomNavigationView.loadNavigationBar()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        configureUI()
    }
}

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
        gradient.colors = [UIColor.systemIndigo.cgColor, UIColor.systemTeal.cgColor]
        gradient.locations = [0, 1]
        view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = view.frame
    }
}

extension BaseViewController {
    
    func configureCustomNavigaionView() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let safeGuide = self.view.safeAreaLayoutGuide
        navBar.setupSafeArea(guide: safeGuide)
        NavBarConstants.rootNavigationController = self.navigationController
        NavBarConstants.barBGColor = UIColor.systemIndigo
        NavBarConstants.transparentBGColor = UIColor.black.withAlphaComponent(0.5)
        NavBarConstants.rightNavButtonImage = UIImage(named: "logout")!
        NavBarConstants.titleColor = UIColor.init(hexString: "#F3F3F3", alpha: 1.0)
        NavBarConstants.transparentTitleColor = UIColor.init(hexString: "#F3F3F3", alpha: 1.0)
        NavBarConstants.titleFont = (UIFont.init(name: "Avenir Next Condensed", size: 23) ?? nil)!
        navBar.configureNavigationBar()
    }
}
