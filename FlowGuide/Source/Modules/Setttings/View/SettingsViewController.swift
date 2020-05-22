//
//  SettingsViewController.swift
//  FlowGuide
//
//  Created by Talish George on 16/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor  = .gray
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        PresenterManager.shared.show(vc: .onBoarding)
    }
}
