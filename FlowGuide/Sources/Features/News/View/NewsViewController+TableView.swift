//
//  NewsViewController+TableView.swift
//  FlowGuide
//
//  Created by TCS on 25/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import UIKit
import UtilitiesLib

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView Data Source Protocol
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.newsCell, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let newsData = viewModel.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
        cell.updateUI(value: newsData)
        return cell
    }
    
    // MARK: - UITableView Delege Protocol
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.CellIdentifiers.newsHeaderCell) as? NewsHeaderView
            else {
                return UITableViewHeaderFooterView()
        }
        let headerName = viewModel.categoryAtIndex(index: section).name
        headerCell.updateUI(value: headerName)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.indexPathForSelectedRow != nil else {
            fatalError("Unable to get the selected row")
        }
        if SDKManager.shared.featureFlag {
            performSegue(withIdentifier: Constants.Segue.showNewsDetail, sender: self)
        } else {
            view.popup.topAnchor = view.safeAreaLayoutGuide.topAnchor
            view.popup.style.bar.hideAfterDelaySeconds = TimeInterval(AppConstants.delaySeconds)
            view.popup.success(String.News.featureEnableInfo.localized)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    /// Register cell
    func registerCell() {
        let headerNib = UINib.init(nibName: Constants.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.CellIdentifiers.newsHeaderCell)
    }
}
