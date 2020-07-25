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
        registerCell()
        if let email = viewModel.authService.auth.currentUser?.email {
            userNameLabel.text = AppConstants.loggedIn + email
        }
        viewModel.delegate = self
        populateNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        removeGradient(gradientView: view)
        configureUI()
        tableView.reloadData()
    }
    
    func setupUI() {
        navigationController?.navigationBar.barTintColor = ThemeManager.shared.theme?.viewGradientTopColor ?? UIColor.systemIndigo
        tableView.layer.borderWidth = AppConstants.NewsConstants.tableViewBorderWidth
        tableView.layer.borderColor = ThemeManager.shared.theme?.borderColor.cgColor
        self.title = AppConstants.NavigationTitle.home
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
