//
//  NewsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

/// News ViewController
class NewsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var newsTableViewOutlet: UITableView!
    
    var categoryListVM: CategoryListViewModel?
    var newsService: WebService = WebService()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Loading Header from Bundle
        let headerNib = UINib.init(nibName: Constants.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        newsTableViewOutlet.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.CellIdentifiers.newsHeaderCell)
        self.title = Constants.NavigationTitle.home
        if let email = Auth.auth().currentUser?.email {
            userNameLabel.text = Constants.CoreApp.loggedIn + email
        }
        populateNews()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewsDetailsViewController {
            let newsDetailsVC = segue.destination as? NewsDetailsViewController
            guard let indexPath = newsTableViewOutlet.indexPathForSelectedRow else {
                fatalError("Unable to get the selected row")
            }
            let articleVM = self.categoryListVM?.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
            newsDetailsVC?.article = articleVM?.article
        }
    }
}

private extension NewsViewController {
    
    /// Fetch News by category
    func populateNews() {
        fetchNews(by: ApiConstants.newsCategory)
    }
    
    /// GET API Request: Fetch News by category
    /// - Parameter category: String
    func fetchNews(by category: String) {
        MBProgressHUD.showAdded(to: view, animated: true)
        self.newsService.getNewsData(category: category, success: { news in
            DispatchQueue.main.async {
                self.loadData(categories: news)
            }
        }, failure: { error in
            guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
                self.presentAlertWithTitle(title: NewsLocalization.newsFecthError.localized, message: NewsLocalization.newsFetchErrorMessage.localized, options: NewsLocalization.ok.localized, NewsLocalization.cancel.localized) { (value) in
                    if value == 0 {
                        self.loadData(categories: Category.loadLocalData())
                    }
                }
                return
            }
        })
    }
    
    /// Fetch Local Data
    /// - Parameter categories: Category Array
    func loadData(categories: [Category]) {
        self.categoryListVM = CategoryListViewModel(categories: categories)
        self.newsTableViewOutlet.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
