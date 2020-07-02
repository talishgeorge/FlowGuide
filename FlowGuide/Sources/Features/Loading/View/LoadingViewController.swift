//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 15/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import UtilitiesLib

final class LoadingViewController: BaseViewController {
    
    var timer: Timer?

    // MARK: - Properties
    
    @IBOutlet private weak var loadingLabel: UILabel!
    private let loginViewModel = LoginViewModel()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.text = LoadingLocalization.loading.localized
        loadingLabel.text = "Loading ."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoading()
        delay(durationInSeconds: 2.5, completion: {
            self.showInitialView()
        })
    }
    
    // MARK: - Private Methods
    
    /// Show Loading
    func showLoading() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.40, repeats: true) { _ in
            var string: String {
                switch self.loadingLabel.text {
                case "Loading .":       return "Loading .."
                case "Loading ..":      return "Loading ..."
                case "Loading ...":     return "Loading ."
                default:                return "Loading"
                }
            }
            self.loadingLabel.text = string
        }
    }
    /// Show Initial View
    private func showInitialView() {
        if LoadingViewModel.isUserLoggedIn() {
            PresenterManager.shared.show(viewMode: .mainTabBarConttoller)
        } else {
            performSegue(withIdentifier: Constants.Segue.showOnBoarding, sender: nil)
        }
    }
}
