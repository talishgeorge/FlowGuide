//
//  NewsViewController+TableView.swift
//  FlowGuide
//
//  Created by Talish George on 25/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit
import Loaf

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView Data Source Protocol
    
    /// Return Number of Sections
    /// - Parameter tableView: UITTableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryListVM == nil ? 0 : categoryListVM?.numberOfSections ?? 0
    }
    
    /// Return Number of Rows in Sections
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: Int Value
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryListVM == nil ? 0 : categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    /// Return Cell for Row
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.newsCell, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let newsData = self.categoryListVM?.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
        cell.updateUI(value: newsData)
        return cell
    }
    
    // MARK: - UITableView Delege Protocol
    
    /// Header for Section
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: Int Value
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.CellIdentifiers.newsHeaderCell) as? NewsHeaderView
            else {
                return UITableViewHeaderFooterView()
        }
        let headerName = categoryListVM?.categoryAtIndex(index: section).name
        headerCell.updateUI(value: headerName)
        return headerCell
    }
    
    /// Selected Row
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: Indexpath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.indexPathForSelectedRow != nil else {
            fatalError("Unable to get the selected row")
        }
        if let featureFlag = SDKManager.shared.featureFlag, featureFlag == true {
            performSegue(withIdentifier: Constants.Segue.showNewsDetail, sender: self)
        } else {
            Loaf(NewsLocalization.feature_enable_info.localized, state: .error, location: .top, sender: self).show()
        }
    }
    
    /// Height for Row
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
