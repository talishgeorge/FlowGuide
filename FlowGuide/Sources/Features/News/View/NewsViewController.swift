//
//  NewsViewController.swift
//  FlowGuide
//
//  Created by TCS on 21/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib
import OakLib

/// News ViewController
final class NewsViewController: BaseViewController {
    
    var viewModel = CategoryListViewModel()
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Loading Header from Bundle
        setupUI()
        registerCell()
        if let email = viewModel.authService.auth.currentUser?.email {
            userNameLabel.text = Constants.loggedIn + email
        }
        viewModel.delegate = self
        populateNews()
    }
    
    func setupUI() {
        navigationController?.navigationBar.barTintColor = themeManager.theme?.viewGradientTopColor ?? UIColor.systemIndigo
        tableView.layer.borderWidth = Constants.News.tableViewBorderWidth
        tableView.layer.borderColor = themeManager.theme?.borderColor.cgColor
        title = Constants.NavigationTitle.home
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewsDetailsViewController {
            let newsDetailsVC = segue.destination as? NewsDetailsViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("Unable to get the selected row")
            }
            let articleVM = viewModel.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
            newsDetailsVC?.viewModel = NewsDetailsViewModel(articleVM.article)
        }
    }
}

// MARK: - Internal Methods

private extension NewsViewController {
    
    /// Fetch News by category
    func populateNews() {
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        viewModel.fetchNews(by: ApiConstants.newsCategory)
    }
}
