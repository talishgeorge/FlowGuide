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
import UtilitiesLib

/// Protocol
protocol NewsViewControllerDelegate: class {
    func loadData(categories: [Category])
    func showError(error: Error?)
}

/// News ViewController
class NewsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var newsTableViewOutlet: UITableView!
    
    var categoryListVM = CategoryListViewModel()
    //    var newsService: WebService = WebService()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Loading Header from Bundle
        navigationController?.navigationBar.barTintColor = UIColor(named: "ThemeBlueTop")! 
        newsTableViewOutlet.layer.borderWidth = 1.2
        newsTableViewOutlet.layer.borderColor = UIColor(named: "ThemeBlueTop")?.cgColor
        let headerNib = UINib.init(nibName: Constants.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        newsTableViewOutlet.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.CellIdentifiers.newsHeaderCell)
        self.title = Constants.NavigationTitle.home
        if let email = Auth.auth().currentUser?.email {
            userNameLabel.text = Constants.CoreApp.loggedIn + email
        }
        categoryListVM.delegate = self
        populateNews()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewsDetailsViewController {
            let newsDetailsVC = segue.destination as? NewsDetailsViewController
            guard let indexPath = newsTableViewOutlet.indexPathForSelectedRow else {
                fatalError("Unable to get the selected row")
            }
            let articleVM = self.categoryListVM.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
            newsDetailsVC?.article = articleVM.article
        }
    }
}

private extension NewsViewController {
    
    /// Fetch News by category
    func populateNews() {
        MBProgressHUD.showAdded(to: view, animated: true)
        categoryListVM.fetchNews(by: ApiConstants.newsCategory)
    }
}

extension NewsViewController: NewsViewControllerDelegate {
    
    func loadData(categories: [Category]) {
        MBProgressHUD.showAdded(to: view, animated: true)
        self.categoryListVM = CategoryListViewModel(categories: categories)
        self.newsTableViewOutlet.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showError(error: Error?) {
        guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
            self.presentAlertWithTitle(title: NewsLocalization.newsFecthError.localized, message: NewsLocalization.newsFetchErrorMessage.localized, options: NewsLocalization.ok.localized, NewsLocalization.cancel.localized) { (value) in
                if value == 0 {
                    self.loadData(categories: Category.loadLocalData())
                }
            }
            return
        }
    }
}
