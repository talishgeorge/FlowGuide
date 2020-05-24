//
//  LoginViewController.swift
//  FlowGuide
//
//  Created by Talish George on 20/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import MBProgressHUD
import Loaf

final class LoginViewController: BaseViewController {
    
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var segmentedControll: UISegmentedControl!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var sigunpButton: UIButton!
    @IBOutlet private weak var passwordConfirmationTextFields: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    weak var delegate: OnBoardingDelegate?
    private let authManager = AuthManager()
    private enum PageType {
        case login
        case signUp
    }
    
    private var currentPageType: PageType = .login {
        didSet {
            setupViewsFor(pageType: currentPageType)
        }
    }
    
    private  var errorMessage: String? {
        didSet {
            showErrorMessage(text: errorMessage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsFor(pageType: currentPageType)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    private func setupViewsFor(pageType: PageType) {
        errorMessage = nil
        passwordConfirmationTextFields.isHidden = pageType == .login
        sigunpButton.isHidden = pageType == .login
        forgotPasswordButton.isHidden = pageType == .signUp
        loginButton.isHidden = pageType == .signUp
    }
    
    private func showErrorMessage(text: String?) {
        errorLabel.isHidden = text == nil
        errorLabel.text = text
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Forget Password?", message: "Please Enter your Email Address", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (_) in
            guard let this = self else {
                return
            }
            if let textField = alertController.textFields?.first,
                let email = textField.text, !email.isEmpty {
                this.authManager.resetPassword(withEmail: email) { [weak self] (result) in
                    guard let this = self else {
                        return
                    }
                    switch result {
                    case .success: 
                    this.showAlert(title: "Password Reset is Successful", message: "Please check your email to find the reset link.")
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .top, sender: this).show(.custom(20)) { dismissalType in
                            switch dismissalType {
                            case .tapped: print("Tapped!")
                            case .timedOut: print("Timmed out!")
                            }
                        }
                    }
                }
            }
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sigunpButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text , !password.isEmpty,
            let confirmationPassword = confirmPasswordTextField.text , !confirmationPassword.isEmpty else {
                showErrorMessage(text: "Invalid Form")
                return
        }
        guard password == confirmationPassword else {
            showErrorMessage(text: "Password are incorrect")
            return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        authManager.signUpNewUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            case .success(let user):
                print("Success: \(String(describing: user.uid))")
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessage(text: error.localizedDescription)
            }
        }
    }
    
    @IBAction func loginButtonTaooed(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text , !password.isEmpty else {
                showErrorMessage(text: "Invalid Form")
                return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        authManager.loginUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            case .success(let user):
                print("Success: \(String(describing: user.uid))")
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessage(text: error.localizedDescription)
            }
        }
    }
    
    @IBAction func segmentedContollValueChanged(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
}


