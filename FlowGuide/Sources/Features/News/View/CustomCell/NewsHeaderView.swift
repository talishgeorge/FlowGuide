//
//  NewsHeader.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

/// News Header Class
class NewsHeaderView: UITableViewHeaderFooterView, TableViewCellProtocol {
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    /// UpdateUI
    /// - Parameter value: Generic Type
    func updateUI<T>(value: T) {
        guard let title = value as? String else { return }
        titleLabel.text = title
    }
}
