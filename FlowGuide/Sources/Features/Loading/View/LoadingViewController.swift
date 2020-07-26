//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by TCS on 15/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib
import Combine

protocol LoadingViewControllerDelegate: AnyObject {
    func navigateToNextPage()
}

final class LoadingViewController: BaseViewController {
    
    private let viewModel = LoadingViewModel()
    @IBOutlet private weak var loadingLabel: UILabel!
    weak var delegate: LoadingViewControllerDelegate?
    let publisher = PassthroughSubject<String, Never>()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.text = String.Loading.loading1.localized
        loadingLabel.textColor = ThemeManager.shared.theme?.fontWhiteColor
        baseSubject
            .handleEvents(receiveOutput: { [unowned self] newItem in
                Authservice().logoutUser()
            })
            .sink { _ in }
            .store(in: &baseSubscriptions)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        showLoading()
        delay(durationInSeconds: AppConstants.LoadingConstants.delayInSeconds, completion: {
            self.showInitialView()
        })
    }
    
    // MARK: - Private Methods
    
    /// Show Loading
    private func showLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: AppConstants.LoadingConstants.timerInterval,
                                 repeats: true) { _ in
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
        if viewModel.isUserLoggedIn() {//TODO
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                let window = sceneDelegate.window {
                window.rootViewController = UIStoryboard.instantiateTabBarController()
                UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        } else {
            publisher.send("From Loading View")
        }
    }
}
