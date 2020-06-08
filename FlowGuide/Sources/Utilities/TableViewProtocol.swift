//
//  TableViewProtocol.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

protocol TableViewProtocol {
    var cellIdentifier: String {get}
    var headerIdentifier: String {get}
    func numberOfRowsInSection() -> Int
    func getCellForRow<T:UITableViewDelegate>(tableView: UITableView, delegate: T, indexPath: IndexPath) -> UITableViewCell
    func getHeader<T:UITableViewDelegate>(tableView: UITableView, delegate: T, section: Int) -> UITableViewHeaderFooterView
    func getSelectedCell(indexPath: IndexPath) -> Any
}

protocol TableViewCellProtocol {
    func updateUI<T>(value: T)
}
