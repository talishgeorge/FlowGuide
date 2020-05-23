//
//  LoginViewController.swift
//  FlowGuide
//
//  Created by Talish George on 20/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase

final class LoginViewController: UIViewController {
    
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
        // TODO
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


