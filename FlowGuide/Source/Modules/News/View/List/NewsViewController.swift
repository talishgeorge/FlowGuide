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
    
    var tableViewDataSource:[TableViewProtocol] = []
    var selectedCell = IndexPath()
    var newsService: WebService = WebService()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: K.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        newsTableViewOutlet.register(headerNib, forHeaderFooterViewReuseIdentifier: K.CellIdentifiers.newsHeaderCell)
        tableViewDataSource = NewsFeedData.newsFeeds
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
            let section = tableViewDataSource[selectedCell.section]
            guard let value =  section.getSelectedCell(indexPath: selectedCell) as? newsInfo else {
                return
            }
            vc?.news = value
        }
    }
}

private extension NewsViewController {
    func populateNews() {
//        CategoryService().getAllHeadlinesForAllCategories(completion: { (categories) in
//            print(categories)
//        })
        
        fetchNews(by: "General")
    }
    
    func fetchWeatherForecast(by city: String) {
        self.newsService.getWeatherData(city: city, success: { forecast in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    // self.weatherForCast = forecast
                    print(forecast)
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
                      print(news)
                  }
              }
          }, failure: { error in
              guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
                  return
              }
          })
      }
}
