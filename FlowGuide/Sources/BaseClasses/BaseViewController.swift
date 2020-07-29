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
import Combine

/// Base ViewController for all ViewController
class BaseViewController: UIViewController, Subscriber {
    
    var navBar = CustomNavigationView.loadNavigationBar()
    typealias Input = Bool
    let baseSubject = PassthroughSubject<String, Never>()
    var baseSubscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        configureUI()
        baseSubject
            .handleEvents(receiveOutput: { [unowned self] _ in
                self.logout()
            })
            .sink { _ in }
            .store(in: &baseSubscriptions)
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: Bool) -> Subscribers.Demand {
        setTheme(isEnable: input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print(completion)
    }
    
    func setTheme(isEnable: Bool) {
        if isEnable {
            ThemeManager.shared.setTheme(theme: AppTheme(file: ThemeConstants.darkMode))
        } else {
            ThemeManager.shared.setTheme(theme: AppTheme(file: ThemeConstants.lightMode))
            
        }
    }
}

// MARK: - Common Altert View

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
        let okAction = UIAlertAction(title: BaseViewLocalization.alertOk.localized, style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Configure Common UI Elements

extension BaseViewController {
    
    /// Setup initial UI
    func configureUI() {
        let gradient = CAGradientLayer()
        gradient.colors = [ThemeManager.shared.theme?.viewGradientTopColor.cgColor ?? UIColor.systemIndigo, ThemeManager.shared.theme?.viewGradientBottomColor.cgColor ?? UIColor.systemTeal]
        gradient.locations = [0, 1]
        view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = view.frame
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.theme?.fontWhiteColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key: Any]
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.theme?.fontWhiteColor ?? UIColor.white]
        
    }
    
    func removeGradient(gradientView: UIView) {
        if let layer = gradientView.layer.sublayers?.first { layer.removeFromSuperlayer()
        }
    }
}

// MARK: - Custom Navigation

extension BaseViewController {
    
    func configureCustomNavigaionView() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let safeGuide = self.view.safeAreaLayoutGuide
        navBar.setupSafeArea(guide: safeGuide)
        NavBarConstants.rootNavigationController = self.navigationController
        NavBarConstants.barBGColor = ThemeManager.shared.theme?.viewGradientTopColor ?? UIColor.systemBlue
        NavBarConstants.transparentBGColor = UIColor.black.withAlphaComponent(0.5)
        NavBarConstants.rightNavButtonImage = UIImage(named: AppConstants.logoutImage) ?? UIImage()
        NavBarConstants.titleColor = ThemeManager.shared.theme?.navigationBarTintColor ?? UIColor.white
        NavBarConstants.transparentTitleColor = ThemeManager.shared.theme?.navigationBarTintColor ?? UIColor.white
        NavBarConstants.titleFont = UIFont.navigationTitle
        navBar.configureNavigationBar()
    }
}

// MARK: - Common Methods

extension BaseViewController {
    
    /// Hide Keyboard
    func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Private Methods
private extension BaseViewController {
    func logout() {
        let result = Authservice().logoutUser()
        switch result {
        case .success:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                let window = sceneDelegate.window {
                window.rootViewController = UIStoryboard.instantiateOnBoardingViewController()
                UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
                ActivityIndicator.dismiss()
            }
        case .failure( _):
            self.view.popup.topAnchor = self.view.safeAreaLayoutGuide.topAnchor
            self.view.popup.style.bar.hideAfterDelaySeconds = TimeInterval(AppConstants.delaySeconds)
            self.view.popup.success(String.News.featureEnableInfo.localized)
            ActivityIndicator.dismiss()
        }
    }
}
