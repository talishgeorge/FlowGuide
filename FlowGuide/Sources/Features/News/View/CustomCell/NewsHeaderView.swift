//
//  NewsHeader.swift
//  FlowGuide
//
//  Created by TCS on 21/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib

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
