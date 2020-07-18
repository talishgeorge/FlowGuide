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

    private let loginViewModel = LoginViewModel()
    @IBOutlet private weak var loadingLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.text = String.Loading.loading1.localized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoading()
        delay(durationInSeconds: LoadingConstants.delayInSeconds, completion: {
            self.showInitialView()
        })
    }
    
    // MARK: - Private Methods
    
    /// Show Loading
    private func showLoading() {
        let timer = Timer.scheduledTimer(withTimeInterval: LoadingConstants.timerInterval, repeats: true) { _ in
            var string: String {
                switch self.loadingLabel.text {
                case String.Loading.loading1.localized:
                    return String.Loading.loading2.localized
                case String.Loading.loading2.localized:
                    return String.Loading.loading3.localized
                case String.Loading.loading3.localized:
                    return String.Loading.loading1.localized
                default:
                    return String.Loading.loading.localized
                }
            }
            self.loadingLabel.text = string
        }
    }
    /// Show Initial View
    private func showInitialView() {
        if LoadingViewModel.isUserLoggedIn() {
            UIRouter.shared.show(viewMode: .mainTabBarConttoller)
        } else {
            performSegue(withIdentifier: Constants.Segue.showOnBoarding, sender: nil)
        }
    }
}
