//
//  NewsViewController+TableView.swift
//  FlowGuide
//
//  Created by Talish George on 25/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import UIKit

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = tableViewDataSource[section]
        return section.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = tableViewDataSource[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("NewsTableViewCell not found")
        }
        return list.getCellForRow(tableView: tableView, delegate: self, indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableViewDataSource[section]
        return header.getHeader(tableView: tableView, delegate: self, section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
        performSegue(withIdentifier: K.Segue.showNewsDetail, sender: self)
    }
}
