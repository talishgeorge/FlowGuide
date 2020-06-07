//
//  NewsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var newsTableViewOutlet: UITableView!
    
    var categoryListVM: CategoryListViewModel?
    var newsService: WebService = WebService()
    var article = Article()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: K.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        newsTableViewOutlet.register(headerNib, forHeaderFooterViewReuseIdentifier: K.CellIdentifiers.newsHeaderCell)
        self.title = K.NavigationTitle.home
        if let email = Auth.auth().currentUser?.email {
            userNameLabel.text = "Logged in - \(email)"
        }
        populateNews()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is NewsDetailsViewController
        {
            let vc = segue.destination as? NewsDetailsViewController
            vc?.news = article
        }
    }
}

private extension NewsViewController {
    func populateNews() {
        CategoryService().getAllHeadlinesForAllCategories(completion: { (categories) in
            self.categoryListVM = CategoryListViewModel(categories: categories)
            self.newsTableViewOutlet.reloadData()
        })
        
        //fetchNews(by: "General")
    }
    
    func fetchWeatherForecast(by city: String) {
        self.newsService.getWeatherData(city: city, success: { forecast in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    // self.weatherForCast = forecast
                }
            }
        }, failure: { error in
            guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
                return
            }
        })
    }
    
    func fetchNews(by category: String) {
        self.newsService.getNewsData(category: category, success: { news in
              if let news = news {
                  DispatchQueue.main.async {
                      // self.weatherForCast = forecast
                  }
              }
          }, failure: { error in
              guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
                  return
              }
          })
      }
}
