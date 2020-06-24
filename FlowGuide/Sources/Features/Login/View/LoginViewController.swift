//
//  LoginViewController.swift
//  FlowGuide
//
//  Created by Talish George on 20/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import MBProgressHUD
import Loaf

/// Login ViewController Class
final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
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
    private var loginViewModel = LoginViewModel()
    private var signUpViewModel = SignUpViewModel()
    
    /// Page Types for login flow
    private enum PageType {
        case login
        case signUp
    }
    
    /// Current page type for login flow
    private var currentPageType: PageType = .login {
        didSet {
            setupViewsFor(pageType: currentPageType)
        }
    }
    
    /// Error message
    private  var errorMessage: String? {
        didSet {
            showErrorMessage(text: errorMessage)
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsFor(pageType: currentPageType)
        setupUIForLocalization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
}

// MARK: - Privte Methods

private extension LoginViewController {
    
    /// Initial View setup
    /// - Parameter pageType: Login or signUp type
    private func setupViewsFor(pageType: PageType) {
        errorMessage = nil
        passwordConfirmationTextFields.isHidden = pageType == .login
        sigunpButton.isHidden = pageType == .login
        forgotPasswordButton.isHidden = pageType == .signUp
        loginButton.isHidden = pageType == .signUp
    }
    
    /// Error message
    /// - Parameter text: Error message String type
    private func showErrorMessage(text: String?) {
        errorLabel.isHidden = text == nil
        errorLabel.text = text
    }
    
    /// Setup Localization
    private func setupUIForLocalization() {
        forgotPasswordButton.setTitle(LoginLocalization.forget_password.localized, for: .normal)
        sigunpButton.setTitle(LoginLocalization.signup.localized, for: .normal)
        loginButton.setTitle(LoginLocalization.login.localized, for: .normal)
        emailTextField.placeholder = LoginLocalization.email.localized
        passwordTextField.placeholder = LoginLocalization.password.localized
        confirmPasswordTextField.placeholder = LoginLocalization.confirm_password.localized
        segmentedControll.setTitle(LoginLocalization.login.localized, forSegmentAt: 0)
        segmentedControll.setTitle(LoginLocalization.signup.localized, forSegmentAt: 1)
    }
}

// MARK: - IBActions

extension LoginViewController {
    
    /// Login Button with TextField Validations
    /// - Parameter sender: UIButton
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text, let password = passwordTextField.text, loginViewModel.formIsValid else {
            showErrorMessage(text: LoginLocalization.invalid_form.localized)
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        loginViewModel.loginUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            case .success( _):
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessage(text: error.localizedDescription)
                self?.presentAlertWithTitle(title: LoginLocalization.loginError.localized, message: LoginLocalization.loginErrorMessage.localized, options: LoginLocalization.ok.localized, LoginLocalization.cancel.localized) { (value) in
                    if value == 0 {
                        this.delegate?.showMainTabBarController()
                    }
                }
            }
        }
    }
    
    /// Forgot Password Button
    /// - Parameter sender: UIButton
    @IBAction private func forgotPasswordButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: LoginLocalization.forget_password.localized, message: LoginLocalization.enter_email.localized, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: LoginLocalization.cancel.localized, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: LoginLocalization.ok.localized, style: .default) { [weak self] (_) in
            guard let this = self else {
                return
            }
            if let textField = alertController.textFields?.first,
                let email = textField.text, !email.isEmpty {
                this.loginViewModel.resetPassword(withEmail: email) { [weak self] (result) in
                    guard let this = self else {
                        return
                    }
                    switch result {
                    case .success:
                        this.showAlert(title: LoginLocalization.password_reset.localized, message: LoginLocalization.check_email.localized)
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .top, sender: this).show(.custom(20)) { dismissalType in
                            switch dismissalType {
                            case .tapped: break
                            case .timedOut: break
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
    
    /// SignUp Button with TextField Validations
    /// - Parameter sender: UIButton
    @IBAction private func sigunpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmationPassword = confirmPasswordTextField.text, signUpViewModel.formIsValid else {
                showErrorMessage(text: LoginLocalization.invalid_form.localized)
                return
        }
        guard password == confirmationPassword else {
            showErrorMessage(text: LoginLocalization.password_incorrect.localized)
            return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        signUpViewModel.signUpNewUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            case .success:
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessage(text: error.localizedDescription)
            }
        }
    }
    
    /// Segement Control
    /// - Parameter sender: UISegementedControl
    @IBAction private func segmentedContollValueChanged(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    /// UITextField Delegate for set values to ViewModel
    /// - Parameter textField: UITextField Type
    func textFieldDidEndEditing(_ textField: UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        loginViewModel = LoginViewModel(email,
                                        password)
        signUpViewModel = SignUpViewModel(email,
                                          password,
                                          confirmPassword)
    }
}
