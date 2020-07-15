//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by TCS on 15/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib

final class LoadingViewController: BaseViewController {
    
    var timer: Timer?
    @IBOutlet private weak var loadingLabel: UILabel!
    private let loginViewModel = LoginViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.text = LoadingLocalization.loading1.localized
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
                case LoadingLocalization.loading1.localized:
                    return LoadingLocalization.loading2.localized
                case LoadingLocalization.loading2.localized:
                    return LoadingLocalization.loading3.localized
                case LoadingLocalization.loading3.localized:
                    return LoadingLocalization.loading1.localized
                default:
                    return LoadingLocalization.loading.localized
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
