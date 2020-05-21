//
//  LoginViewController.swift
//  FlowGuide
//
//  Created by Talish George on 20/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import  MBProgressHUD

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
    private let isSuccessfulLogin = false
    weak var delegate: OnBoardingDelegate?
    
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
        
    }
    
    @IBAction func sigunpButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButtonTaooed(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 2.0) {
            MBProgressHUD.hide(for: self.view, animated: true)
            if self.isSuccessfulLogin {
                self.delegate?.showMainTabBarController()
            }else {
                self.showErrorMessage(text: "Your password is invalid. Please try again.")
            }
        }
    }
    
    @IBAction func segmentedContollValueChanged(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
}


