//
//  LoginViewController.swift
//  FlowGuide
//
//  Created by TCS on 20/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Loaf

/// Login ViewController Class
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
    private var loginViewModel = LoginViewModel()
    private var signUpViewModel = SignUpViewModel()
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var confirmPswdView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loginButtonView: UIView!
    
    @IBOutlet private weak var signUpButtonView: UIView!
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
        confirmPswdView.isHidden = pageType == .login
        signUpButtonView.isHidden = pageType == .login
        forgotPasswordButton.isHidden = pageType == .signUp
        loginButtonView.isHidden = pageType == .signUp
    }
    
    /// Error message
    /// - Parameter text: Error message String type
    private func showErrorMessage(text: String?) {
        errorView.isHidden = text == nil
        errorLabel.text = text
    }
    
    /// Setup Localization
    private func setupUIForLocalization() {
        forgotPasswordButton.setTitle(String.Login.forgetPassword.localized, for: .normal)
        sigunpButton.setTitle(String.Login.signup.localized, for: .normal)
        loginButton.setTitle(String.Login.login.localized, for: .normal)
        emailTextField.placeholder = String.Login.email.localized
        passwordTextField.placeholder = String.Login.password.localized
        confirmPasswordTextField.placeholder = String.Login.confirmPassword.localized
        segmentedControll.setTitle(String.Login.login.localized, forSegmentAt: 0)
        segmentedControll.setTitle(String.Login.signup.localized, forSegmentAt: 1)
        cardView.layer.borderColor = UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor
        emailView.layer.borderColor = UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor
        passwordView.layer.borderColor = UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor
        confirmPswdView.layer.borderColor = UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor
        emailView.layer.borderWidth = CGFloat(LoginConstants.textFieldBorderWidth)
        passwordView.layer.borderWidth = CGFloat(LoginConstants.textFieldBorderWidth)
        confirmPswdView.layer.borderWidth = CGFloat(LoginConstants.textFieldBorderWidth)
        configureButtonUI(customButton: loginButtonView, viewButton: loginButton)
        configureButtonUI(customButton: signUpButtonView, viewButton: sigunpButton)
    }
}

// MARK: - IBActions

private extension LoginViewController {
    
    /// Login Button with TextField Validations
    /// - Parameter sender: UIButton
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let email = emailTextField.text, let password = passwordTextField.text, loginViewModel.formIsValid else {
            showErrorMessage(text: String.Login.invalidForm.localized)
            return
        }
        
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        loginViewModel.loginUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else {
                return
            }
            ActivityIndicator.dismiss()
            switch result {
            case .success( _):
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessage(text: error.localizedDescription)
                self?.presentAlertWithTitle(title: String.Login.loginError.localized, message: String.Login.loginErrorMessage.localized, options: String.Global.ok.localized, String.Global.cancel.localized) { (value) in
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
        let alertController = UIAlertController(title: String.Login.forgetPassword.localized, message: String.Login.enterEmail.localized, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: String.Global.cancel.localized, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: String.Global.ok.localized, style: .default) { [weak self] (_) in
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
                        this.showAlert(title: String.Login.passwordReset.localized, message: String.Login.checkEmail.localized)
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
                showErrorMessage(text: String.Login.invalidForm.localized)
                return
        }
        guard password == confirmationPassword else {
            showErrorMessage(text: String.Login.passwordIncorrect.localized)
            return
        }
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        signUpViewModel.signUpNewUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else {
                return
            }
            ActivityIndicator.dismiss()
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
// MARK: - Delegate Methods
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
