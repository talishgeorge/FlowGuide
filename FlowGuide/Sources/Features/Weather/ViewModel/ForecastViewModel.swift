//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation

class WeatherViewModel {
    private let service = BaseViewModel.shared.webService
    /// Fetch News
    /// - Parameter category: String
    func fetchNews(by category: String) {
        let closureSelf = self
        service.getWeather(cityName: "Delhi") { result in
            //var categories = [Category]()
            switch result {
            case Result.success(let response):
                //let category = Category(title: "General", articles: response.articles)
                //categories.append(category)
                //closureSelf.categories = categories
                DispatchQueue.main.async {
                    //closureSelf.delegate?.serviceStartRefreshingUI(self)
                    print("Success\(response)")
                }
            case Result.failure(let error):
                DispatchQueue.main.async {
                    //closureSelf.delegate?.service(self, didFinishWithError: error)
                     print("Failure")
                }
            }
        }
    }
}
