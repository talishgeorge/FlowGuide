//
//  BaseViewController.swift
//  FlowGuide
//
//  Created by Talish George on 24/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .appBackground
        configureUI()
    }
}

extension BaseViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setDarkTheme() {
        Theme.darkTheme()
    }
    
    func setDefaultTheme() {
        Theme.defaultTheme()
    }
    
    func setBackGroungColor(_ rgb: Int) -> UIColor {
        return UIColor(hex: rgb)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func configureUI() {
        let gradient = CAGradientLayer()
        //gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        gradient.locations = [0,1]
        view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = view.frame
    }
}
