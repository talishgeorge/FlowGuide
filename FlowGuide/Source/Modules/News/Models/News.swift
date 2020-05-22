//
//  News.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

typealias newsInfo = (title:String, description:String)

enum NewsType: String {
    case sports = "Sports"
    case international = "International"
    case domestic = "Domestic"
    case politics = "Politics"
}

enum News: TableViewProtocol {

    case newsList(newsType: String, news: [newsInfo])
    
    var cellIdentifier: String{
        get {K.CellIdentifiers.newsCell}
    }
    
    var headerIdentifier: String{
        get {K.CellIdentifiers.newsHeaderCell}
    }
    
    var newsListDataSource:[newsInfo] {
        get {
            switch self {
            case .newsList(_, news: let list):
                return list
                
            }
        }
    }
    
    var headerName: String {
        get {
            switch self {
            case .newsList(let type, _):
                switch type {
                case NewsType.international.rawValue:
                    return NewsType.international.rawValue
                case NewsType.domestic.rawValue:
                    return NewsType.domestic.rawValue
                case NewsType.sports.rawValue:
                    return NewsType.sports.rawValue
                case NewsType.politics.rawValue:
                    return NewsType.politics.rawValue
                default:
                    return "Others"
                }
            }
        }
    }
    
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
