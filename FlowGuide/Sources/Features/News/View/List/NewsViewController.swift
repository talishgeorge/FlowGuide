//
//  NewsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import MBProgressHUD
import UtilitiesLib

/// Protocol
protocol NewsViewControllerDelegate: class {
    func loadData(vm: CategoryListViewModel)
    func showError(error: Error?)
}

/// News ViewController
final class NewsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var categoryListVM = CategoryListViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Loading Header from Bundle
        navigationController?.navigationBar.barTintColor = UIColor(named: ThemeColor.themeBlueTop.rawValue) ?? UIColor.systemIndigo
        tableView.layer.borderWidth = 1.2
        tableView.layer.borderColor = UIColor(named: ThemeColor.themeBlueTop.rawValue)?.cgColor
        let headerNib = UINib.init(nibName: Constants.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.CellIdentifiers.newsHeaderCell)
        self.title = Constants.NavigationTitle.home
        
        if let email = auth.currentUser?.email {
            userNameLabel.text = Constants.CoreApp.loggedIn + email
        }
        categoryListVM.delegate = self
        populateNews()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewsDetailsViewController {
            let newsDetailsVC = segue.destination as? NewsDetailsViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("Unable to get the selected row")
            }
            let articleVM = self.categoryListVM.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
            newsDetailsVC?.newsDetailsVM = NewsDetailsViewModel(articleVM.article)
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
