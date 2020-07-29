//
//  LoginViewController.swift
//  FlowGuide
//
//  Created by TCS on 20/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import OakLib
import Combine

/// Login ViewController Class
final class LoginViewController: BaseViewController {
    
    @Published var emailPublisher: String = ""
    @Published var passwordPublisher: String = ""
    @Published var confirmPasswordPublisher: String = ""
    var validatePasswordSubscriber: AnyCancellable?
    weak var delegate: OnBoardingDelegate?
    private var loginViewModel = LoginViewModel()
    private var signUpviewModel = SignUpViewModel()
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var segmentedControll: UISegmentedControl!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var sigunpButton: UIButton!
    @IBOutlet private weak var passwordConfirmationTextFields: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var confirmPswdView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loginButtonView: UIView!
    @IBOutlet private weak var signUpButtonView: UIView!
    var showTabBarControllerPublisher = PassthroughSubject<Void, Never>()
    var passwordIsValid: Bool = false
//    var email = ""
//    var password = ""
//    var confirmPassword = ""
    
    /// Page Types for login flow
    private enum PageType {
        case login
        case signUp
    }
    
    /// Current page type for login flow
    private var currentPageType: PageType = .login {
        didSet {
            setupViewForPageType()
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
        setupViewForPageType()
        setupUIForLocalization()
        setupUI()
        setupCardView()
        validatePasswordSubscriber = isPasswordValid.sink(receiveValue: { isValid in
            self.passwordIsValid = isValid
        })
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
    func setupViewForPageType() {
        errorMessage = nil
        confirmPswdView.isHidden = currentPageType == .login
        signUpButtonView.isHidden = currentPageType == .login
        forgotPasswordButton.isHidden = currentPageType == .signUp
        loginButtonView.isHidden = currentPageType == .signUp
    }
    
    /// Error message
    /// - Parameter text: Error message String type
    func showErrorMessage(text: String?) {
        errorView.isHidden = text == nil
        errorLabel.text = text
    }
    
    /// Setup Localization
    func setupUIForLocalization() {
        forgotPasswordButton.setTitle(String.Login.forgetPassword.localized, for: .normal)
        sigunpButton.setTitle(String.Login.signup.localized, for: .normal)
        loginButton.setTitle(String.Login.login.localized, for: .normal)
        emailTextField.placeholder = String.Login.email.localized
        passwordTextField.placeholder = String.Login.password.localized
        confirmPasswordTextField.placeholder = String.Login.confirmPassword.localized
        segmentedControll.setTitle(String.Login.login.localized, forSegmentAt: 0)
        segmentedControll.setTitle(String.Login.signup.localized, forSegmentAt: 1)
    }
    
    func setupUI() {
        emailView.layer.borderColor = ThemeManager.shared.theme?.viewGradientTopColor.cgColor
        passwordView.layer.borderColor = ThemeManager.shared.theme?.viewGradientTopColor.cgColor
        confirmPswdView.layer.borderColor = ThemeManager.shared.theme?.viewGradientTopColor.cgColor
        emailView.layer.borderWidth = AppConstants.LoginConstants.textFieldBorderWidth
        passwordView.layer.borderWidth = AppConstants.LoginConstants.textFieldBorderWidth
        confirmPswdView.layer.borderWidth = AppConstants.LoginConstants.textFieldBorderWidth
        UIView.gradientButton(customButton: loginButtonView, viewButton: loginButton)
        UIView.gradientButton(customButton: signUpButtonView, viewButton: sigunpButton)
    }
    
    func setupCardView() {
        cardView.layer.borderColor = ThemeManager.shared.theme?.viewGradientTopColor.cgColor
    }
}

// MARK: - IBActions

private extension LoginViewController {
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        loginViewModel = LoginViewModel(emailPublisher,
                                        passwordPublisher)
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            loginViewModel.formIsValid else {
                showErrorMessage(text: String.Login.invalidForm.localized)
                return
        }
        
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        loginViewModel.loginUser(withEmail: email, password: password) { [weak self] (result) in
            guard let self = self else {
                return
            }
            ActivityIndicator.dismiss()
            switch result {
            case .success( _):
                self.showTabBarControllerPublisher.send()
            case .failure(let error):
                self.showErrorMessage(text: error.localizedDescription)
                self.presentAlertWithTitle(title: String.Login.loginError.localized, message: String.Login.loginErrorMessage.localized, options: String.Global.ok.localized, String.Global.cancel.localized) { (value) in
                    if value == 0 {
                        self.showTabBarControllerPublisher.send()
                    }
                }
            }
        }
    }
    
    /// Forgot Password Button
    /// - Parameter sender: UIButton
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: String.Login.forgetPassword.localized, message: String.Login.enterEmail.localized, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: String.Global.cancel.localized, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: String.Global.ok.localized, style: .default) { [weak self] (_) in
            guard let strongSelf = self else {
                return
            }
            if let textField = alertController.textFields?.first,
                let email = textField.text, !email.isEmpty {
                strongSelf.loginViewModel.resetPassword(withEmail: email) { [weak self] (result) in
                    guard let strongSelf = self else {
                        return
                    }
                    switch result {
                    case .success:
                        strongSelf.showAlert(title: String.Login.passwordReset.localized, message: String.Login.checkEmail.localized)
                    case .failure(let error):
                        self?.view.popup.topAnchor = self?.view.safeAreaLayoutGuide.topAnchor
                        self?.view.popup.style.bar.hideAfterDelaySeconds = TimeInterval(AppConstants.delaySeconds)
                        self?.view.popup.success(error.localizedDescription)
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
    @IBAction func sigunpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmationPassword = confirmPasswordTextField.text,
            !email.isEmpty,
            !password.isEmpty,
            !confirmationPassword.isEmpty  else {
                showErrorMessage(text: String.Login.invalidForm.localized)
                return
        }
        signUpviewModel = SignUpViewModel(email,
                                          passwordPublisher,
                                          confirmPasswordPublisher)
        guard passwordIsValid else {
            self.showErrorMessage(text: String.Login.passwordIncorrect.localized)
            return
        }
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        signUpviewModel.signUpNewUser(withEmail: email, password: password) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            ActivityIndicator.dismiss()
            switch result {
            case .success:
                strongSelf.showTabBarControllerPublisher.send()
            case .failure(let error):
                strongSelf.showErrorMessage(text: error.localizedDescription)
            }
        }
    }
    
    /// Segement Control
    /// - Parameter sender: UISegementedControl
    @IBAction func segmentedContollValueChanged(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
}

// MARK: - Text Field Delegate Methods

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailPublisher = emailTextField.text!
        passwordPublisher = passwordTextField.text!
        confirmPasswordPublisher = confirmPasswordTextField.text!
    }
    
    var isPasswordValid: AnyPublisher<Bool, Never> {
        return $passwordPublisher.combineLatest($confirmPasswordPublisher) { (password, confirmPassword)  in
            var isValid = false
            isValid = self.signUpviewModel.isValidPassword(password, confirmPassword)
            return isValid
        }
        .eraseToAnyPublisher()
    }
}
