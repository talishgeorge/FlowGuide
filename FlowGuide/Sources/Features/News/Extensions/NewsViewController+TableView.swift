//
//  NewsViewController+TableView.swift
//  FlowGuide
//
//  Created by Talish George on 25/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView Data Source Protocol
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryListVM == nil ? 0 : categoryListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryListVM == nil ? 0 : categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.newsCell, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let newsData = self.categoryListVM?.categoryAtIndex(index: indexPath.section).articleAtIndex(indexPath.row)
        cell.updateUI(value: newsData)
        return cell
    }
    
    // MARK: - UITableView Delege Protocol
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.CellIdentifiers.newsHeaderCell) as? NewsHeaderView
            else{
                return UITableViewHeaderFooterView()
        }
        let headerName = categoryListVM?.categoryAtIndex(index: section).name
        headerCell.updateUI(value: headerName)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //article = viewModel.selectedCell(section: indexPath.section, indexPath: indexPath.row)
        performSegue(withIdentifier: Constants.Segue.showNewsDetail, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
