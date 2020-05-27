//
//  News.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

class NewsViewModel: BaseViewModel, TableViewProtocol {
    
    // MARK: - Properties
    
    var newsType:String = ""
    
    var news: [newsInfo] = []
    
    init(type: String, list: [newsInfo]) {
        self.newsType = type
        self.news = list
    }
    
    
    var cellIdentifier: String{
        get {K.CellIdentifiers.newsCell}
    }
    
    var headerIdentifier: String{
        get {K.CellIdentifiers.newsHeaderCell}
    }
    
    var newsListDataSource:[newsInfo] {
        get { return news }
    }
    
    var headerName: String {
        get { return newsType }
    }
}

// MARK: - Internal Methods

extension NewsViewModel {
    func numberOfRowsInSection() -> Int {
        return newsListDataSource.count
    }
    
    func getCellForRow<T>(tableView: UITableView, delegate: T, indexPath: IndexPath) -> UITableViewCell where T : UITableViewDelegate {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let name:newsInfo = newsListDataSource[indexPath.row]
        cell.updateUI(value: name)
        return cell
    }
    
    func getHeader<T>(tableView: UITableView, delegate: T, section: Int) -> UITableViewHeaderFooterView where T : UITableViewDelegate {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as? NewsHeaderView
            else{
                return UITableViewHeaderFooterView()
        }
        headerCell.updateUI(value: headerName)
        return headerCell
    }
    func getSelectedCell(indexPath: IndexPath) -> Any {
        return newsListDataSource[indexPath.row]
    }
}
