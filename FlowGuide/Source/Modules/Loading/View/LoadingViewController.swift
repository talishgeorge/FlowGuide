//
//  LoadingViewController.swift
//  FlowGuide
//
//  Created by Talish George on 15/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

final class LoadingViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var loadingLabel: UILabel!
    private let loginViewModel = LoginViewModel()
    var weatherService: Services = Services()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.text = LoadingLocalization.loading.localized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delay(durationInSeconds: 2.0, completion: {
            self.showInitialView()
        })
    }
    
    // MARK: - Private Methods
    
    private func showInitialView() {
        if LoadingViewModel.isUserLoggedIn() {
            PresenterManager.shared.show(viewMode: .mainTabBarConttoller)
        }else {
            performSegue(withIdentifier: K.Segue.showOnBoarding, sender: nil)
        }
        //fetchWeatherForecast(by: "Delhi")
    }
    
    func fetchWeatherForecast(by city: String) {
        self.weatherService.getWeatherData(city: city, success: { forecast in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    //                    self.weatherForCast = forecast
                    print(forecast)
                }
            }
        }, failure: { error in
            guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
                return
            }
        })
    }
}
